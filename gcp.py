import sys
import os

if __name__ == "__main__":
	args = sys.argv[1:]

	for arg in args:
		print(type(arg))

	# if len(args) == 0:
	# 	os.system(u'git add . && \
	# 				git commit -m "# some lil fixes" \
	# 				&& git push origin master')
	# elif len(args) == 1:
	# 	if os.path.exists(args[0]):
	# 		os.system(u'git add '+ args[0] + ' && \
	# 		git commit -m "# some lil fixes" \
	# 		&& git push origin master')
	# 	else:
	# 		os.system(u'git add && \
	# 		git commit -m "' + args[0] + '" \
	# 		&& git push origin master')			
	# elif len(args) == 2:
	# 	os.system(u'git add '+ args[0] + ' && \
	# 	git commit -m "' + args[1] + '" \
	# 	&& git push origin master')
	# elif len(args) == 3:
	# 	os.system(u'git add '+ args[0] + ' && \
	# 	git commit -m "' + args[1] + '" \
	# 	&& git push origin ' + args[2])
	# else:
	# 	print(u'Allowed only 3 args')