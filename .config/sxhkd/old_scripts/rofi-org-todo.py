#!/bin/python3
import sys
import os
from datetime import date
from rofi import Rofi

# path to where you want your TODOs to be inserted to
inbox_file = "/home/barbarossa/org/TODO.org"
r = Rofi()


def todo_to_inbox():
    todo = r.text_entry(
        "TODO",
        message="""Usage:
    Type full text of org TODO and any tags 
    eg. Code rofi-org-todo for fast adds to inbox  :mensch:w33:
    """,
    )
    if todo is not None:
        f = open(inbox_file, "a")
        f.write("\n** TODO ")
        f.write(todo + "\n")
        f.write(":PROPERTIES:\n")
        f.write(":CREATED: " + "[" + date.today().strftime("%Y-%m-%d %a") + "]\n")
        f.write(":END:\n\n")
        f.close()


todo_to_inbox()
