#!/usr/bin/python
# -*- coding: utf-8 -*-


class FilterModule(object):

    def filters(self):
        return {'mrget': self.mrget}

    def mrget(self, data):
        users = set([item['name'] for item in data])
        members = [{'name': name, 'member': [item['member'] for item in data if item['name'] == name]} for name in users]
        return members