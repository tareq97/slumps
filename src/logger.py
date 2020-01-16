# -*- coding: utf-8 -*-

from utils import bcolors, DEBUG_FILE


class Logger(object):

    def __init__(self, debugToFile=False):
        self.debugToFile = debugToFile
        self.indent = 0

    def enter(self):
        self.indent += 1

    def exit(self):
        self.indent -= 1

    def getIndent(self):
        return "\t" * self.indent

    def debug(self, message, std=None):

        if self.debugToFile:
            if isinstance(message, list):
                DEBUG_FILE.write(message)
            else:
                DEBUG_FILE.write(message.encode("utf-8"))
            if std:
                if isinstance(std, list):
                    DEBUG_FILE.write(std.__str__().encode("utf-8"))
                else:
                    DEBUG_FILE.write(std)
        else:
            print("%s%s%s%s" % (self.getIndent(), bcolors.UNDERLINE, message, bcolors.ENDC))

    def error(self, message):
        print("%s%s%s%s" % (self.getIndent(), bcolors.FAIL, message, bcolors.ENDC))

    def warning(self, message):
        print("%s%s%s%s" % (self.getIndent(), bcolors.WARNING, message, bcolors.ENDC))

    def info(self, message):
        print("%s%s%s%s" % (self.getIndent(), bcolors.OKBLUE, message, bcolors.ENDC))

    def success(self, message):
        print("%s%s%s%s" % (self.getIndent(), bcolors.OKGREEN, message, bcolors.ENDC))


LOGGER = Logger(True)  # Output debug calls to debug.slumps.log file