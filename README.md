<b>SystemUM (User Manager)</b>

[![SystemUM - Logo](https://s24.postimg.org/jrdhqazj9/system.png)](#)<br><br>
Program made in bash which allows you to have total control of the information of each of the users that are connected in it. It mainly shows the following attributes: 
- Entry time to the system <br>
- Permanence in the system <br>
- Exit time <br>
- Public IP <br> 
- Open processes that currently have each of them <br>
- CPU consumption by each of the open processes of the users of the system as well as the longer process that they run on their computers in the system <br>
- Registry of the history of users who have accessed the system with their corresponding IP in that moment<br>
- User group to which they belongs looking at the hierarchy that you have established (you will have to modify part of the code or adapt it to it)<br> 
- Check if the user has a valid boot shell or it is an internal user<br>
- Filtering users passed by parameter<br>

Here you have a table for './myusers.sh' options

| Options  | Function |
| ------------- | ------------- |
| **-h**  | Help (Show Options)  |
| **-u user_name \| --user user_name**  | Find an user as parameter  |
| **-n user_name**  | Extract and delete an user from list  |
| **-l number \| --  last number**  | Show 'x' last user logins to system  |
| **-t \| --time**  | Show system user access time |
| **TIME**  | CPU running time for user processes |





<b>You may execute the file remotely from a system</b>
