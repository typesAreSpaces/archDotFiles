from os import system as cmd

elements = set()
f = open(".arch_packages_new", "r")
for x in f:
    elements.add(x)
    
todo = set()
f = open(".arch_packages_old", "r")
for x in f:
    if(not (x in elements)):
        todo.add(x)

for x in todo:
    command = "paru -R " + x
    cmd(command)
