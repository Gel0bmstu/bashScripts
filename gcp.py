#!/usr/bin/python3

import sys
import os

if __name__ == "__main__":
	args = sys.argv[1:]        

	if len(args) == 0:
		out = os.popen(u'git add . && git commit -m \"# some lil fixes\" && git push origin master').read()
	elif len(args) ==1:
		if os.path.exists(args[0]):
			out = os.popen(u'git add ' + args[0] + ' && git commit -m "# some lil fixes" && git push origin master').read()
		else:
			out = os.system(u'git add . && git commit -m "' + args[0] + '" && git push origin master').read()			
	elif len(args) == 2:
		out = os.popen(u'git add '+ args[0] + ' && git commit -m "' + args[1] + '" && git push origin master').read()
	elif len(args) == 3:
		out = os.popen(u'git add '+ args[0] + ' && git commit -m "' + args[1] + '" && git push origin ' + args[2]).read()
	else:
		print(u'Allowed only 3 args')

	# if out == ""