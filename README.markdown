Scalarium API wrapper
===========

About
--
This library simplifies and automates the interaction with Scalarium's API. It makes all the common operations for obtaining 
Clouds with their instances and roles a breeze. <br />
It is very easy to integrate this library with 
your application to control your instances (restart, stop, start) and applications (deploy/redeploy) from the command line 

<!--
Since Scalarium is currently (June 2011) not supporting members' roles and therefore it is troublesome/risky to give all the development team members full access to the clouds/applications this library will allow easy setup of local environments for anyone minimizing the risk of 'stoping' the production environment. 
For example limiting only to one cloud or application (development environment).
 -->

All the documentation for Scalarium API - ([http://support.scalarium.com/kb/api](http://support.scalarium.com/kb/api))

It can:

* Obtain a list of all clouds with their instances & roles 
* Obtain a list of all applications plus their deployements
* Perform deploy of specified application, with custom comment and enabled migrations command
* Interact with the clouds stop/start/restart clouds (Still under development)



 
Install
-- 
  Clone this repository 
 <pre><code>$ git clone https://luki3k5@github.com/luki3k5/scalarium-api-wrapper.git </code></pre>
  or install the gem
 <pre><code>$ gem install scalarium-api-wrapper </code></pre>




Setup
--
  You need to pass your api token to the Scalarium.configuration: 
   <pre>
<code>Scalarium.configuration.api_token = "YOUR TOKEN"</code></pre>

You can obtain your token at ([https://manage.scalarium.com/users](https://manage.scalarium.com/users)) - I highly encourage to setup a new user in scalarium (i.e. devdeploy) and then render him new API_TOKEN. 




Usage
--

After the api token is set you can create API class instance: 


<pre>
<code>api = Scalarium::API.new</code>
</pre>

and then for example execute a deploy for one of your applications: 

<pre>
<code>api.deploy_application('application_id')</code>
</pre>

This will return hash containing information about current deploy:
[Scalarium Documentation details](http://support.scalarium.com/kb/api/fetching-deployment-details)

We can then use the 'id' from the above hash and current application id to call for information about the progress:

<pre>
<code>api.fetch_deployment_details('application_id','deployment_id')</code>
</pre>

NOTE: We can always see the deploy status if we know proper deployment_id (even from the deploys that have been already finished)


to obtain list of all available applications execute:
<pre>
<code>api.get_applications</code>
</pre> 

notice that this will return array of all applications currently available for this user account.
To get ID one could execute: 

<pre>
<code>api.get_applications.each do |app|
  puts "app name: #{app['name']}  -- app id: #{app['id']} "
end</code>
</pre> 

Here are the fields returned in each hash:
<pre>
<code>
 "id", 
 "name", 
 "ssl_certificate", 
 "scm_url", 
 "application_type", 
 "rails_env", 
 "deleted_at", 
 "ssl_certificate_key", 
 "scm_revision", 
 "ssl_support", 
 "scm_ssh_key", 
 "scm_user", 
 "domain_names", 
 "document_root", 
 "created_at", 
 "scm_password", 
 "auto_bundle_on_deploy", 
 "updated_at", 
 "mounted_at", 
 "description", 
 "domain_name", 
 "ssl_certificate_ca", 
 "cluster_id", 
 "scm_type", 
 "slug_name"</code>
</pre>

for their meaning check Scalarium's documentation and examples

Ruby on Rails integration
--

Here is a simple [RAKE task](https://gist.github.com/1037410) that illustrates how this library could be used with Rails application.



Contributing
--

* Fork this project

* Check with TODO.txt what could be worked on 

* Push your contribution to a branch named after your change
  ie: git push origin master:added-feature-name

* Try to write tests first, so we know it works beforehand  

* Send me a pull request through GitHub with a description of
  what you are contributing.



License
--

Copyright (c) 2011 Lukasz Lazewski

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


Credits
--

luki3k5 (Lukasz Lazewski) 

