# Intelligem

A local coding agent, used to 'spark ideas'.

A coding agent that can connect to a vast array of llms (openai, anthropic, gemini, deepseek, ollama and more).


## How to Use

To start the cli, execute

`./exe/intelligem`

### Help

`./exe/intelligem help` 

## Architecture

The application is built with Ruby and the Ruby LLM gem, powered via the CLI with the cli-kit gem. 

CLI UI is provided by the cli-ui gem. 

Core gems (libraries): 
 - [cli-kit](https://github.com/Shopify/cli-kit)
 - [cli-ui](https://github.com/Shopify/cli-ui)
 - [ruby_llm](https://rubyllm.com)