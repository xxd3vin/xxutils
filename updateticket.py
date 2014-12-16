#!/usr/bin/python2.7
# -*- coding: utf-8 -*-

'''
Add comment to a exist ticket
Example : sudo python newcomment.py -i 11547 -c "54321" -a "ci"
'''

import os, sys
from optparse import OptionParser

reload(sys)
sys.setdefaultencoding('utf8')

#
# get params from command line
#

parser = OptionParser()
parser.add_option("-i", "--id", dest="id",
                  help="ticket id")
parser.add_option("-c", "--comment", dest="comment",
                  help="ticket comment")
parser.add_option("-a", "--author", dest="author",
                  help="ticket comment author")

(options, args) = parser.parse_args()

#
# begin to add comment to a ticket
#

TRAC_ENV = os.environ.get('TRAC_ENV') or os.path.expanduser('/home/trac/glue')
if not os.path.isdir(TRAC_ENV):
    print >>sys.stderr, "Set TRAC_ENV to the Trac project directory."
    sys.exit(2)

from trac.env import open_environment
from trac.ticket import Ticket
t = Ticket(open_environment(TRAC_ENV), options.id, version=None)

num = t.save_changes(options.author, options.comment)
if not num:
    print >>sys.stderr, "Comment not added to ticket"
    sys.exit(1)

print "Ticket %s add comment, comment:%d" % (options.id, num)
sys.exit(0)                 # all is well
