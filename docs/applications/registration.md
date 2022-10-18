# Building your own applications

First of all, you need to create your own application and to receive a pair of **app\_id/app\_secret**.
This pair will be used to generate an OAuth2 token to authenticate your users
(see [Authentication](../authentication.md) ).

To start you should sign up as a user in the web application
(for testing we use https://web.test.goldblocx.com), then register a corporate account
(see 'Add Business User' menu), because all applications must be linked to a corporate entity.

After completion the registration, you can see the DEV sub-menu item in the header menu of the web application,
see the picture below:

<img src="./dev.png" width=600 height=200  alt="Goldblocx Web Application"/>

The DEV menu contains the information about applications you company owns.
You can create a new application, modify existing ones (i.e. set the app\_secret
values) and also remove unused applications.

There is a way to manage your applications through API, for details, please see
[Applications](./applications.md). Also, with the use of Applications API you can
create an application without a need of Goldblocx Web App.
