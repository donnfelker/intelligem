# Shine

A local CLI agent written in Ruby that can be used for coding, analysis, etc.

This project aims to illustrate, once again ... how Ruby shines.

## Setup

Before using Shine, you need to create a `.env` file in the project root directory with your API keys for the LLM providers you want to use.

### Example .env file

```
ANTHROPIC_API_KEY=your-anthropic-api-key-here
```

**Note:** Currently, only Anthropic is supported. You can get your API key from [https://console.anthropic.com/account/keys](https://console.anthropic.com/account/keys).

## Usage

To start the cli, execute

`./exe/shine agent`

### Help

`./exe/shine help` 

## Architecture

The application is built with Ruby and the Ruby LLM gem, powered via the CLI with the cli-kit gem.

### Tools

The agent's tools are built using the Ruby LLM gem's tool system, which provides structured function calling capabilities to interact with the LLM. The tools are located in the `lib/shine/agent/tools/` directory.

Currently supported tools:
- **Read File** - Read contents of files
- **Edit File** - Modify existing files
- **List Files** - Browse directory contents
- **Run Shell Command** - Execute shell commands
- **Fetch URL** - Retrieve content from URLs 

CLI UI is provided by the cli-ui gem. 

Core gems (libraries): 
 - [cli-kit](https://github.com/Shopify/cli-kit)
 - [cli-ui](https://github.com/Shopify/cli-ui)
 - [ruby_llm](https://rubyllm.com)