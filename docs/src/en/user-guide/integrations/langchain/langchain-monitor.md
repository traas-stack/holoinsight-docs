# LangChainMonitor plugin
Configure environment variables in the environment of your service
```
export DD_SERVICE="your_app_name"
```
Import [**ddtrace**](https://github.com/DataDog/dd-trace-py) package in the LangChain code
```
pip install ddtrace>=1.17
```
Below is a code sample that you can run directly to test
```
import os
from langchain import OpenAI
from langchain.chat_models import ChatOpenAI
from flask import Flask
from ddtrace import tracer, patch

app = Flask(__name__)
tag = {
    'env': 'test',
    'tenant': 'default', # Configuring tenant information
    'version': 'v0.1'
}
# Set the Collector_DataDog address and port
tracer.configure(
    hostname="localhost",
    port="5001"
)
tracer.set_tags(tag)
patch(langchain=True)

os.environ["OPENAI_API_KEY"] = "sk-***********" # Enter the openai api_key
os.environ["OPENAI_PROXY"] = "******"           # Configure proxy addresses as required

@app.route('/test/langchain')
def hello_world():
    return ChatFuc('gpt-3.5-turbo')

def OpenAIFuc(model):
    random_string = 'Hello World!'
    chat = OpenAI(temperature=0, model_name=model, max_tokens=50)
    return chat.predict(random_string)

def ChatFuc(model):
    random_string = 'Hello World!'
    chat = ChatOpenAI(temperature=0, model_name=model)
    return chat.predict(random_string)


if __name__ == '__main__':
    app.run(port=5003)
```
Calling interface
```
curl --location --request GET 'localhost:5003/test/langchain'
```
Open page http://localhost:8080/integration/agentComp?tenant=default.

Install the LangChainMonitor plug-in on the Integration Components page
![langchain1.png](langchain1.png)
Click to preview
![langchain2.png](langchain2.png)

LangChain monitoring dashboards can be automatically generated to monitor token usage and interface requests
![langchain3.png](langchain3.png)

![langchain4.png](langchain4.png)

