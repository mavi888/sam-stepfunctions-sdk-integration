ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

run:
	docker run -p 8083:8083 \
  	--mount type=bind,readonly,source=$(ROOT_DIR)/state-machine/test/MockConfigFile.json,destination=/home/StepFunctionsLocal/MockConfigFile.json \
  	-e SFN_MOCK_CONFIG="/home/StepFunctionsLocal/MockConfigFile.json" \
  	amazon/aws-stepfunctions-local

create:
	aws stepfunctions create-state-machine \
		--endpoint-url http://localhost:8083 \
		--definition file://state-machine/state-machine.asl.json \
		--name "LocalTesting" \
		--role-arn "arn:aws:iam::123456789012:role/DummyRole" \
		--no-cli-pager

happy:
	aws stepfunctions start-execution \
		--endpoint http://localhost:8083 \
		--name HappyPathTest \
		--state-machine arn:aws:states:us-east-1:123456789012:stateMachine:LocalTesting#HappyPathTest \
		--no-cli-pager

fileNotFound:
	aws stepfunctions start-execution \
		--endpoint http://localhost:8083 \
		--name FileNotFoundTest \
		--state-machine arn:aws:states:us-east-1:123456789012:stateMachine:LocalTesting#FileNotFoundTest \
		--no-cli-pager


all: create happy fileNotFound

happy-h:
	aws stepfunctions get-execution-history \
		--endpoint http://localhost:8083 \
		--execution-arn arn:aws:states:us-east-1:123456789012:execution:LocalTesting:HappyPathTest \
		--query 'events[?type==`ExecutionSucceeded`]' \
		--no-cli-pager

fileNotFound-h:
	aws stepfunctions get-execution-history \
		--endpoint http://localhost:8083 \
		--execution-arn arn:aws:states:us-east-1:123456789012:execution:LocalTesting:FileNotFoundTest \
		--query 'events[?type==`ExecutionFailed` && executionFailedEventDetails.error==`S3.NoSuchBucketException`]' \
		--no-cli-pager

history: happy-h fileNotFound-h