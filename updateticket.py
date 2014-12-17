#!/usr/bin/python2.7
# -*- coding: utf-8 -*-

'''
Update a exist ticket
Example : sudo python updateticket.py -i 11547 -c "54321" -a "ci" -s "reopened"
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
                  help="ticket update author")
parser.add_option("-s", "--status", dest="status",
                  help="ticket status")

(options, args) = parser.parse_args()

#
# begin to change a ticket
#

TRAC_ENV = os.environ.get('TRAC_ENV') or os.path.expanduser('/home/trac/glue')
if not os.path.isdir(TRAC_ENV):
    print >>sys.stderr, "Set TRAC_ENV to the Trac project directory."
    sys.exit(2)

from trac.env import open_environment
from trac.ticket import Ticket
t = Ticket(open_environment(TRAC_ENV), options.id, version=None)

info = dict(
    status=options.status
)

t.populate(info)

num = t.save_changes(options.author, unicode(options.comment, 'utf-8'))
if not num:
    print >>sys.stderr, "Failed to update a exist ticket"
    sys.exit(1)

print "Ticket %s updated, comment:%d" % (options.id, num)
sys.exit(0)                 # all is well
