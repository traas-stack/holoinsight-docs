# Log charset
When read logs from file, HoloInsight-Agent use `github.com/saintfish/chardet` to detect the real charset of logs.  
But this guess is not necessarily correct, its result depends on the given log sample, and it may be wrong, which results in mojibake.

Now only support for UTF8 and GB18030 is good.

It is recommended to only use UTF8 encoding when printing logs to avoid garbled characters in various links.