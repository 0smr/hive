TEMPLATE = subdirs
SUBDIRS = \
    Hive \
    example

example.depends = Hive
