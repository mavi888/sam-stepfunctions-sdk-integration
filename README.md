# AWS Step Functions - SDK Integrations

_Infrastructure as code framework used_: AWS SAM, ASL
_AWS Services used_: AWS Step functions, Amazon S3, Amazon Transcribe, Amazon Transcribe, Amazon Translate

## Summary of the demo

In this demo you will see:

- How to create a State Machine using ASL and the AWS SDK integrations
- How to define a state machine using AWS SAM
- How to transcribe an existing video/audio file and translate it into spanish

This demo is part of a video posted in FooBar Serverless channel. You can check the video to see the whole demo.

## Deploy this demo

We will be using AWS SAM and make sure you are running the latest version - at the time of writing, this was 1.37.0 (sam --version).

Deploy the project to the cloud:

```
sam deploy -g # Guided deployments
```

When asked about functions that may not have authorization defined, answer (y)es. The access to those functions will be open to anyone, so keep the app deployed only for the time you need this demo running.

Next times, when you update the code, you can build and deploy with:

```
sam deploy
```

To delete the app:

```
sam delete
```

## Links related to this code

- Video with more details: https://youtu.be/jtmQJqaInT0
- Launch blog post: https://aws.amazon.com/blogs/aws/now-aws-step-functions-supports-200-aws-services-to-enable-easier-workflow-automation/s
