-module (erlcloud_cloudformation).

-include_lib("erlcloud/include/erlcloud.hrl").
-include_lib("erlcloud/include/erlcloud_aws.hrl").

-export ([list_stacks/1,
		  list_stack_resources/2,
		  describe_stack_resources/2,
		  describe_stack_resource/3,
		  desribe_stacks/2,
		  get_stack_policy/2,
		  get_template/2,
		  get_template_summary/3,
		  describe_account_limits/1,
		  describe_stack_events/2]).

list_stacks(Config = #aws_config{}) ->
	cloudformation_request(Config, "ListStacks", []).

list_stack_resources(StackId, Config = #aws_config{}) ->
	cloudformation_request(Config, "ListStackResources", [{"StackName", StackId}]).

describe_stack_resources(StackId, Config = #aws_config{}) ->
	cloudformation_request(Config, "DescribeStackResources", [{"StackName", StackId}]).

describe_stack_resource(StackId, LogicalResourceId, Config = #aws_config{}) ->
	cloudformation_request(Config, "DescribeStackResource", [{"StackName", StackId}, 
															 {"LogicalResourceId", LogicalResourceId}
															]).

desribe_stacks(StackId, Config = #aws_config{}) ->
	cloudformation_request(Config, "DescribeStacks", [{"StackName", StackId}]).

get_stack_policy(StackId, Config = #aws_config{}) ->
	cloudformation_request(Config, "GetStackPolicy", [{"StackName", StackId}]).

describe_stack_events(StackId, Config = #aws_config{}) ->
	cloudformation_request(Config, "DescribeStackEvents", [{"StackName", StackId}]).

get_template(StackId, Config = #aws_config{}) ->
	cloudformation_request(Config, "GetTemplate", [{"StackName", StackId}]).

get_template_summary(StackId, TemplateUrl, Config = #aws_config{}) ->
	cloudformation_request(Config, "GetTemplateSummary", [{"StackName", StackId}, 
														  {"TemplateURL", TemplateUrl}
														 ]).

describe_account_limits(Config = #aws_config{}) ->
	cloudformation_request(Config, "DescribeAccountLimits", []).

cloudformation_request(Config = #aws_config{}, Action, ExtraParams) ->

	QParams = [
		{"Action", Action},
		{"Version", "2010-05-15"}
		| ExtraParams],

	erlcloud_aws:aws_request_xml4(post, Config#aws_config.cloudformation_host, "/", QParams, "cloudformation", Config).
