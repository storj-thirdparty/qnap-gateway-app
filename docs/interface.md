Endpoint: interface.php
=======================
​
API: dashboard-info
===================
Returns credentials and bucket info.
​
Input
-----
{
​
        apiRequest: "dashboard-info"
}
​
Output
------
{

	accessKey: "xxx",
	secretKey: "xxx",
	satellite: "xxx"
}
​
API: wizard-save
===================
Saves user input after finishing the wizard.
​
Input
-----
{
​
        apiRequest: "wizard-save",
	satellite: "xxx",
	apiKey: "xxx",
	passphrase: "xxx"
}
​
Output
------
{
​
}
​
​
​
API: gateway-action
===================
Send command to run/stop/restart the gateway-action
​
Input
------
{
​
        apiRequest : "gateway-action",
	action: "xxx",        // The value can be "run" "stop" "restart"
}
​
Output
-------
{
​
	status: "xxx", // Values shall be "running", "stopped", "restarted"
}
​
ERROR Cases
===========
In case of any error during request / execution, output will contain error param
​
Output
-------
​
{
​
	...
	...
	error: "xxx",
}
​
​
Unknown APIs
=============
​
Input
-----
​
{
​
	<<<<Does not contains apiRequest or invalid API name>>>
}
​
Output
------
Only in case of some value being null
​
{
​
	error: "Invalid or Unknown API Request",
}
