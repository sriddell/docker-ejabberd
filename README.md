#Dockerfile for ejabberd.

Allows ejabberd to run in a docker container, with the mnesia database externalized.

Before building the container, edit the start.sh script and set the DOMAIN correctly for the host that will run the docker container.

Also edit the ejabberd.cfg and search for the Admin user and Hostname sections and set the hostname appropriately.

```
%% Admin user
{acl, admin, {user, "admin", "myhost"}}.

%% Hostname
{hosts, ["myhost"]}.
```

To start it, use somthing like

```
sudo docker run -d -v /home/myself/data:/etc/lib/ejabberd -p 5222:5222 -p 5280:5280 -p 5080:5080 -h ejabberd -name ejabberd ejabberd
```

Note the -h option to set the hostname if using external storage for the mnesia db in /etc/lib/ejabberd.  Unless the hostname is consistent, a new container instance using the external mnesia db will fail.

When started the first time, use the docker logs command to see the logs and the autogenerated password for the ejabberd admin account.

The admin interface will be running on port 5280.
