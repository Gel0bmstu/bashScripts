#!/usr/bin/python3

import sys, os
import subprocess

if __name__ == "__main__":
	try:
		args = sys.argv[1:]

		if len(args) == 1 and (args[0] == "--help" or args[0] == "-help" or args[0] == '-h' or args[0] == "help"):
			print("gcp: Git - Commit - Push command. Helps you to speed up your work with git")
			print("\ngcp (file|commit message|branch)\n")
			# print("Examples of use:")
			# print("gcp filename - specify only file name, then the changed file with commit message \"updated\"")
			# print("               will be commited to master branch.")
			# print("gcp \'commit_message\' - specify only file name, then the changed file with commit message \"updated\"")
			# print("               will be commited to master branch.")
			sys.exit(0)

		if len(args) == 0:
			subprocess.check_output(['git', 'commit', '-am'] + ["# update"])
			subprocess.check_output(['&&', 'git', 'push', 'origin', 'master'])
		elif len(args) == 1:
			if os.path.exists(args[0]):
				subprocess.check_output('git add {file} && git commit -m "# update {file}" && git push origin master'.format(file=args[0]).split())
			else:
				subprocess.check_output("git commit -am \"{}\" && git push origin master".format(args[0]))		
		elif len(args) == 2:
			subprocess.check_output("git add {file} && git commit -m \"{message}\" && git push origin master".format(file=args[0], message=args[1]).split())
		elif len(args) == 3:
			subprocess.check_output("git add {file} && git commit -m \"{message}\" && git push origin \"{branch}\"".format(\
				file=args[0], message=args[1], branch=args[2]).split())
		else:
			print('Allowed only 3 or less args')
		
		sys.exit(0)
	except Exception as e:
		print('There is some errors: {}'.format(e))
		sys.exit(-1)
