# Solution of Logstash
```palin
input {
  stdin {
    codec => multiline {
      pattern => "pattern, a regexp"
      negate => "true" or "false"
      what => "previous" or "next"
    }
  }
}
```
The meaning of this configuration expression is that lines which match 'pattern' and 'negate' are belong to 'what' line group.

A concrete example:
```text
2023-03-25 16:27:56 [INFO] [main] log foo bar baz
java.lang.RuntimeException: foobar message
  at io.holoinsight.foo.bar.baz ... 
2023-03-25 16:27:57 [INFO] [main] log foo bar baz
java.lang.RuntimeException: foobar message
  at io.holoinsight.foo.bar.baz ... 
```

```palin
input {
  stdin {
    codec => multiline {
      pattern => "^[0-9]{4}-[0-9]{2}-[0-9]{2}"
      negate => false
      what => "previous"
    }
  }
}
```
The meaning of this configuration expression is that lines which don't match pattern `^[0-9]{4}-[0-9]{2}-[0-9]{2}` are belong to previous line group.

Line 1 '2023-03-25 16:27:56 [INFO] [main] log foo bar baz' matched, it terminates the previous line group and starts a new line group with itself as the first line.  
Line 2 'java.lang.RuntimeException: foobar message' doesn't match, it is belongs to previous line group.  
Line 3 'at io.holoinsight.foo.bar.baz ...' doesn't match, it is belongs to previous line group.  
Line 4 '2023-03-25 16:27:57 [INFO] [main] log foo bar baz' matched, it terminates the previous line group and starts a new line group with itself as the first line.  
Line 5 'java.lang.RuntimeException: foobar message' doesn't match, it is belongs to previous line group.  
Line 6 'at io.holoinsight.foo.bar.baz ...' doesn't match, it is belongs to previous line group.  

## References
- [plugins-codecs-multiline](https://www.elastic.co/guide/en/logstash/2.3/plugins-codecs-multiline.html)

# Solution of HoloInsight
```json
{
  "multiline": {
    "enabled": "true or false",
    "where": "condition to match",
    "what": "previous || next"
  }
}
```

HoloInsight's multi-line solution is basically aligned with Logstash. But it has its own characteristics.   
We combine pattern and negate and use where to express. where is more expressive than pattern + negate.


A concrete example:
```text
2023-03-25 16:27:56 [INFO] [main] log foo bar baz
java.lang.RuntimeException: foobar message
  at io.holoinsight.foo.bar.baz ... 
2023-03-25 16:27:57 [INFO] [main] log foo bar baz
java.lang.RuntimeException: foobar message
  at io.holoinsight.foo.bar.baz ... 
```

```json
{
  "multiline": {
    "enabled": true,
    "where": {
      "not": {
        "regexp": {
          "elect": {
            "type": "line"
          },
          "pattern": "^[0-9]{4}-[0-9]{2}-[0-9]{2}"
        }
      }
    },
    "what": "previous"
  }
}
```
The meaning of this configuration expression is that lines which don't match pattern `^[0-9]{4}-[0-9]{2}-[0-9]{2}` are belong to previous line group.

Line 1 '2023-03-25 16:27:56 [INFO] [main] log foo bar baz' matched, it terminates the previous line group and starts a new line group with itself as the first line.  
Line 2 'java.lang.RuntimeException: foobar message' doesn't match, it is belongs to previous line group.  
Line 3 'at io.holoinsight.foo.bar.baz ...' doesn't match, it is belongs to previous line group.  
Line 4 '2023-03-25 16:27:57 [INFO] [main] log foo bar baz' matched, it terminates the previous line group and starts a new line group with itself as the first line.  
Line 5 'java.lang.RuntimeException: foobar message' doesn't match, it is belongs to previous line group.  
Line 6 'at io.holoinsight.foo.bar.baz ...' doesn't match, it is belongs to previous line group.  

