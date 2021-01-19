#! /usr/bin/python

from cgi import FieldStorage
from sys import argv


TTY = '/dev/tty0'

END_TOGGLES = {
	'|': '|',
	'/': '\\',
	'^': '^',
	'\\': '\\'
}
COLOURS = {
	'|': '\033[40m \033[m',
	'~': '\033[41m \033[m',
	'/': '\033[42m \033[m',
	'\\': '\033[42m \033[m',
	'^': '\033[43m \033[m',
	'`': '\033[44m \033[m',
	'*': '\033[45m \033[m',
	'+': '\033[46m \033[m',
	'&': '\033[47m \033[m'
}


def _display_char_colour(ch, toggle, out):
	ret_toggle = toggle

	if ch in COLOURS:
		colour = COLOURS[ch]

		if toggle and ch == END_TOGGLES[toggle]:
			ret_toggle = None
		elif ch in END_TOGGLES:
			ret_toggle = END_TOGGLES[ch]
	elif toggle in END_TOGGLES:
		colour = COLOURS[toggle]

		if ch == END_TOGGLES[toggle]:
			ret_toggle = None
	elif ch == '\n':
		colour = '\n'
	else:
		colour = ' '

	out.write(colour)
	return ret_toggle


def _display_HTML_page(msg):
	print 'Content-type: text/html\n\n'
	print '<HTML><HEAD><TITLE>Merry Christmas once again!</TITLE></HEAD>'
	print '<BODY><p>{}</p></BODY></HTML>'.format(msg)


def main():
	out = open(TTY, 'a')
	toggle = None

	try:
		f = FieldStorage()['tree_file.txt'].file
		
		out.write('\n')
		for line in f.readlines():
			for ch in line:
				toggle = _display_char_colour(ch, toggle, out)
		out.write('\n')

		msg = 'Check the QEMU terminal...'
	except:
		msg = 'You had one job: to upload a file!!!'

	_display_HTML_page(msg)


if __name__ == '__main__':
	main()
