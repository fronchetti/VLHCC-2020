# -*- coding: utf-8 -*-

__author__ =  'Felipe Fronchetti'
__contact__ = 'fronchetti@usp.br'

import urllib2
import time
from datetime import datetime
import json

# TO-DO: Handle internet connection. Maybe a good idea is to use requests instead of urllib2.

class Collector:

    def __init__(self, client_id, client_secret):
        self.client_id = client_id
        self.client_secret = client_secret
        self.rate_limit_remaining = None
        self.rate_limit_reset = None

    def request(self, path, parameters=[]):

        if not parameters:
            github_url = 'https://api.github.com/' + path + '?client_id=' + self.client_id + '&client_secret=' + self.client_secret
            print('Creating a requisition: ' + path)
        else:
            github_url = 'https://api.github.com/' + path + '?client_id=' + self.client_id + '&client_secret=' + self.client_secret + '&' + '&'.join(parameters)
            print('Creating a composed requisition: ' + path + '?' + '&'.join(parameters))

        try:
            request = urllib2.Request(github_url)

            if 'stargazer' in github_url:
                request.add_header('Accept','application/vnd.github.v3.star+json')

            response = urllib2.urlopen(request)
            response_body = json.load(response)
            response_header = response.info()
            self.verify_rate_limit(response_header)

            return response_body

        except (urllib2.HTTPError) as http_error:
            with open('error.log', 'a') as log_file:
                log_file.write('(HTTP) Error ' + str(http_error.code) + ': \n')
                log_file.write(github_url + '\n')
            return None

        except (urllib2.URLError,) as connection_error:
            print('The internet is not working. Trying again in a few seconds.')

            with open('error.log', 'a') as log_file:
                log_file.write('(CONNECTION) Error: \n')
                log_file.write(connection_error.reason + '\n')

            time.sleep(60)
            response_body = self.request(path, parameters)
            return response_body

    def verify_rate_limit(self, header):

        for parameter in header.items():
            if 'x-ratelimit-remaining' in parameter:
                self.rate_limit_remaining = int(parameter[1])
            if 'x-ratelimit-reset' in parameter:
                self.rate_limit_reset = int(parameter[1])
                
        datetime_format = '%Y-%m-%d %H:%M:%S'
        reset_time = datetime.fromtimestamp(self.rate_limit_reset).strftime(datetime_format)
        current_time = datetime.now().strftime(datetime_format)

        print('[API] Requests Remaining:' + str(self.rate_limit_remaining))

        if self.rate_limit_remaining < 15:
            while(reset_time > current_time):
                print('The request limit is over. The process is sleeping until it can be resumed.')
                print('The limit will reset on: ' + reset_time)
                current_time = datetime.now().strftime(datetime_format)
                time.sleep(60)
