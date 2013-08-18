Using an existing rails application to authenticate your Discourse users
via OAuth2.

Assumptions
===========

1. You have an existing Rails app.
2. You want a private forum, accesible only to users within your existing
application.

Discourse Configuration
=======================

Log in as the admin user and disable all authentication types.
Your plugin authentication type doesn't need to be explicitly enabled.
Any authentication provider in your plugin is enabled by default.

Include your styles in your plugin.

Generate your Oauth Application ID and Application Secret. You'll need
to include both of these in your environment (see env.sh.sample).
