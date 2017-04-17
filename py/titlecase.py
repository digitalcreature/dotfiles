import re

# match empty string before uppercase letters
camel = re.compile(r'(\S)([A-Z])')
# match sequences of common word seperators
seperators = re.compile(r'[-._]+')
# match first letters of words
firstletters = re.compile(r'(\s|^)([a-z])')

def titlecase(s):
	s = camel.sub(r'\1 \2', s)
	s = seperators.sub(r' ', s)
	def toupper(m):
		return m.group(1) + m.group(2).upper()
	s = firstletters.sub(toupper, s)
	return s.strip()

if __name__ == "__main__":
	from sys import argv
	if (len(argv) >= 2):
		print(titlecase(argv[1]))
		exit(0)
	else:
		print("usage: python titlecase.py <string>")
		exit(1)
