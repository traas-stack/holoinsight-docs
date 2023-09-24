# OpenAIMonitor 插件
在您服务的环境中配置环境变量
```
export DD_SERVICE="your_app_name"
```
在调用OpenAI代码中引入 [**ddtrace**](https://github.com/DataDog/dd-trace-py) 包
```
pip install ddtrace>=1.13
```
下面是代码示例，你可以直接运行来测试
```
import openai
from flask import Flask
from ddtrace import tracer, patch

app = Flask(__name__)
tag = {
    'env': 'test',
    'tenant': 'default', # 配置租户信息
    'version': 'v0.1'
}
# 配置Collector_DataDog地址及端口
tracer.configure(
    hostname='localhost',
    port='5001'
)
tracer.set_tags(tag)
patch(openai=True)

@app.route('/test/openai')
def hello_world():
    openai.api_key = 'sk-***********' # 填写openai的api_key
    openai.proxy = '*******'          # 按需配置代理地址
    return ChatCompletion('gpt-3.5-turbo')


def ChatCompletion(model):
    content = 'Hello World!'
    messages = [{'role': 'user', 'content': content}]
    result = openai.ChatCompletion.create(api_key=openai.api_key, model=model, messages=messages)
    print('prompt_tokens: {}, completion_tokens: {}'.format(result['usage']['prompt_tokens'],
                                                         result['usage']['completion_tokens']))
    return result

def Completion(engine):
    content = 'Hello World!'
    result = openai.Completion.create(engine=engine, prompt=content, max_tokens=50)
    print('prompt_tokens: {}, completion_tokens: {}'.format(result['usage']['prompt_tokens'],
                                                            result['usage']['completion_tokens']))
    return result


if __name__ == '__main__':
    app.run(port=5002)
```
调用接口
```
curl --location --request GET 'localhost:5002/test/openai'
```
打开页面 http://localhost:8080/integration/agentComp?tenant=default.

在集成组件页面安装OpenAIMonitor插件
![openai1.png](openai1.png)
点击预览
![openai2.png](openai2.png)

可以自动生成OpenAI监控仪表盘，监控token使用情况及接口请求情况
![openai3.png](openai3.png)

![openai4.png](openai4.png)

