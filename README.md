# AWS Step Functions - SDK Integrations

_Infrastructure as code framework used_: AWS SAM, ASL
_AWS Services used_: AWS Step functions, Amazon S3, Amazon Transcribe, Amazon Transcribe, Amazon Translate

## Summary of the demo

This is a sample application which showcases how to use Step Functions with AWS SAM, SDK integrations and
local testing using mock configs.

In this example you won't find any Lambda function, but instead direct calls from the state machine to the different AWS Services.

We are also showing how to test locally the state machine, using mock configs. Mock configs allows a developer to mock the output of service integrations that are present in a state machine.

Developers can provide a valid sample output from the service call API that is present in the state machine as mock data. This allows developers to test the behavior of the state machine in isolation.

In this demo you will see:

- How to create a State Machine using ASL and the AWS SDK integrations
- How to define a state machine using AWS SAM
- How to transcribe an existing video/audio file and translate it into spanish
- How to test locally a State Machine
- How to create a MockConfigFile
- How to run this automatically

This demo is part of a video series posted in FooBar Serverless channel. You can check the videos to see the whole demo.

## Overview of the state machine

This state machine takes a video or audio in English, stored in an S3 bucket. Transcribe this file with Amazon Transcribe, then grabs the transcriptions and gets the transcript for the text using Amazon Transcribe. And finally with the transcribed text uses Amazon Translate to get the spanish version of the text.

![StateMachine](https://d2908q01vomqb2.cloudfront.net/da4b9237bacccdf19c0760cab7aec4a8359010b0/2021/09/08/07-statemachine-750x1024.png)

## Deploy this demo

We will be using AWS SAM and make sure you are running the latest version - at the time of writing, this was 1.37.0 (sam --version).

Deploy the project to the cloud:

```
sam deploy -g # Guided deployments
```

You will need to input the S3 bucket and object key where your audio/video file is stored.

Next times, when you update the code, you can build and deploy with:

```
sam deploy
```

To delete the app:

```
sam delete
```

## Test locally

To test the state machine locally you will first need to download the step functions local docker image.

Following the user guide, you can either run Step Functions local as a [JAR](https://docs.aws.amazon.com/step-functions/latest/dg/sfn-local-computer.html) or as a [Docker container](https://docs.aws.amazon.com/step-functions/latest/dg/sfn-local-docker.html). Steps below will focus on the docker container approach.

```
docker pull amazon/aws-stepfunctions-local
```

Then you can run all the tests in the `makefile`

On a terminal window, first start with running docker:

```bash
make run
```

On a different terminal window/tab, you can then run:

```bash
make all
```

Finally, you can check history of each execution by running:

```bash
make history
```

Check [`makefile`](./makefile) for details

## Links related to this code

- Video about Step function Service Integration: https://youtu.be/jtmQJqaInT0
- Video about testing Step functions using Mocked service integrations: TBD
- Launch blog post of Step function SDK service integration: https://aws.amazon.com/blogs/aws/now-aws-step-functions-supports-200-aws-services-to-enable-easier-workflow-automation/
- Documentation on using Mocked Service Integration: https://docs.aws.amazon.com/step-functions/latest/dg/sfn-local-test-sm-exec.html#run-mocked-serv-integ-tests
- Launch blog post of Mocked Service Integration: https://aws.amazon.com/blogs/compute/mocking-service-integrations-with-aws-step-functions-local/
