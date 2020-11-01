This Demo creates an EC2 instance.
It then downloads a docker image from the docker repo and runs it.
It then installs a jenkins app within the docker container.

The remote-exec feature should be used as a last resort!
The intent of this demo is to show how remote-exec can be used in this situation
A viable alternative would be to the user-data feature to bootstrap all
installations and updates.

Finally, in order to adhere to best practices, all variables are defined and stored in the variables.tf folder