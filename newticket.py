#!/usr/bin/python2.7
# -*- coding: utf-8 -*-

#/**************************************************************************
# *
# *  This file is part of the OSC(Open Source Communit).
# *  Copyright (C) by SanPolo Co.Ltd.
# *  All rights reserved.
# *
# *  See http://osc.spolo.org/ for more information.
# *
# *  SanPolo Co.Ltd
# *  http://www.spolo.org/  spolo@spolo.org sales@spolo.org
# *
#**************************************************************************/

'''
trac-bug: add bug/feature to current Trac project, from the command line.
Specify Trac project directory in TRAC_ENV environment variable.
'''

import os, sys
from optparse import OptionParser

reload(sys)
sys.setdefaultencoding('utf8')

# @param {Dict} options ticket field like owner, etc.
# @return {Dict}
# {
#   "status": 0 is success, otherwise failed.
#   "id": ticket number. If status is not 0, the id field is not given.
# }
def run(options):

  #
  # defualt value
  #
  
  T_STATUS = 'new'
  T_MILESTONE = ''
  
  #
  # begin to create new  ticket
  #
  
  TRAC_ENV = os.environ.get('TRAC_ENV') or os.path.expanduser('/home/trac/glue')
  if not os.path.isdir(TRAC_ENV):
    print >>sys.stderr, "Set TRAC_ENV to the Trac project directory."
    #sys.exit(2)
    return {
      "status": 2
    }
  
  from trac.env import open_environment
  from trac.ticket import Ticket
  t = Ticket(open_environment(TRAC_ENV))
  
  info = dict(
    status=T_STATUS, 
    owner=options["owner"], reporter=options["reporter"], cc=options["cc"],
    milestone=T_MILESTONE, type=options["type"],
    summary=options["summary"].decode(sys.getfilesystemencoding()),
    description = options["description"].decode(sys.getfilesystemencoding())
  )
  
  t.populate(info)
  num = t.insert()
  if not num:
    print >>sys.stderr, "Ticket not created"
    print >>sys.stderr, vals
    #sys.exit(1)
    return {
      "status": 1
    }
  
  #print "Ticket #%d" % (num)
  return {
    "status": 0,
    "id": num
  }

if __name__ == "__main__":
  #
  # get params from command line
  #
  
  parser = OptionParser()
  parser.add_option("-r", "--reporter", dest="reporter",
                    help="ticket reporter")
  parser.add_option("-o", "--owner", dest="owner",
                    help="ticket owner")
  parser.add_option("-t", "--type", dest="type",
                    help="ticket type")
  parser.add_option("-s", "--summary", dest="summary",
                    help="ticket summary")
  parser.add_option("-d", "--description", dest="description",
                    help="ticket description")
  parser.add_option("-c", "--cc", dest="cc",
                    help="ticket cc")
  
  (options, args) = parser.parse_args()

  # Convert object to dict
  _options = {}
  _options["reporter"] = options.reporter
  _options["owner"] = options.owner
  _options["type"] = options.type
  _options["summary"] = options.summary
  _options["description"] = options.description
  _options["cc"] = options.cc

  run(_options)

  sys.exit(0)                 # all is well
