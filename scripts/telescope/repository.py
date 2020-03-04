# -*- coding: utf-8 -*-

__author__ =  'Felipe Fronchetti'
__contact__ = 'fronchetti@usp.br'

class Repository:

    def __init__(self, organization, name, collector):
        self.name = name
        self.organization = organization
        self.github = collector

    def custom_request(self, url):
        return self.github.request(url)

    def about(self):
        print('[Repository] Returning general information about' + self.name)
        return self.github.request('repos/' + self.organization + '/' + self.name)

    def languages(self):
        print('[Repository] Returning languages used in the project')
        return self.github.request('repos/' + self.organization + '/' + self.name + '/languages')

    def readme(self):
        print('[Repository] Returning README available in ' + self.name)

        files = []
        filenames = ['README.md', 'README', 'README.markdown', 'README.MD']

        for filename in filenames:
            readme = self.github.request('repos/' + self.organization + '/' + self.name + '/contents/' + filename)

            if readme:
                files.append(readme)

        return files

    def contributing(self):
        print('[Repository] Returning CONTRIBUTING available in ' + self.name)

        files = []
        filenames = ['CONTRIBUTING.md', 'CONTRIBUTING', 'CONTRIBUTING.markdown', 'CONTRIBUTING.MD']

        for filename in filenames:
            contributing = self.github.request('repos/' + self.organization + '/' + self.name + '/contents/' + filename)

            if contributing:
                files.append(contributing)

        return files

    def code_of_conduct(self):
        print('[Repository] Returning CODE_OF_CONDUCT available in ' + self.name)

        files = []
        filenames = ['CODE_OF_CONDUCT.md', 'CODE_OF_CONDUCT', 'CODE_OF_CONDUCT.markdown', 'CODE_OF_CONDUCT.MD']

        for filename in filenames:
            code_of_conduct = self.github.request('repos/' + self.organization + '/' + self.name + '/contents/' + filename)

            if code_of_conduct:
                files.append(code_of_conduct)

        return files

    def commit(self, sha):
        print('[Repository] Returning commit ' + str(sha) + ' in ' + self.name)
        return self.github.request('repos/' + self.organization + '/' + self.name + '/commits/' + str(sha))

    def pull_request(self, number):
        print('[Repository] Returning pull-request #' + str(number) + ' in ' + self.name)
        return self.github.request('repos/' + self.organization + '/' + self.name + '/pulls/' + str(number))

    def issue(self, number):
        print('[Repository] Returning issue #' + str(number) + ' in ' + self.name)
        return self.github.request('repos/' + self.organization + '/' + self.name + '/issues/' + str(number))

    def commits(self, sha=None, path=None, author=None, since=None, until=None, page_range={}):
        print('[Repository] Returning commits available in ' + self.name)

        commits = []
        parameters = []

        if sha is not None:
            parameters.append('sha=' + sha)
        if path is not None:
            parameters.append('path=' + path)
        if author is not None:
            parameters.append('author=' + author)
        if since is not None:
            parameters.append('since=' + since)
        if until is not None:
            parameters.append('until=' + until)

        if page_range:
            first_page = page_range['first_page']
            last_page = page_range['last_page']

            for page_number in range(first_page, last_page):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/commits', parameters + ['page=' + str(page_number)])

                if request:
                    for commit in request:
                        commits.append(commit)
        else:
            pages_exist = True
            page_number = 1

            while(pages_exist):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/commits', parameters + ['page=' + str(page_number)])

                if request:
                    for commit in request:
                        commits.append(commit)
                else:
                    pages_exist = False

                page_number = page_number + 1

        return commits
    
    def pull_requests(self, state=None, direction=None, sort=None, base=None, head=None, page_range={}):
        print('[Repository] Returning pull-requests available in ' + self.name)
        pull_requests = []
        parameters = []

        if state is not None:
            parameters.append('state=' + state)
        if direction is not None:
            parameters.append('direction=' + direction)
        if sort is not None:
            parameters.append('sort=' + sort)
        if base is not None:
            parameters.append('base=' + base)
        if head is not None:
            parameters.append('head=' + head)

        if page_range:
            first_page = page_range['first_page']
            last_page = page_range['last_page']

            for page_number in range(first_page, last_page):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/pulls', parameters + ['page=' + str(page_number)])

                if request:
                    for pull_request in request:
                        pull_requests.append(pull_request)
        else:
            pages_exist = True
            page_number = 1

            while(pages_exist):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/pulls', parameters + ['page=' + str(page_number)])

                if request:
                    for pull_request in request:
                        if pull_request:
                            if 'number' in pull_request:
                                pull_request = self.pull_request(pull_request['number'])
                                pull_request['reviews'] = self.pull_request_reviews(pull_request['number'])
                                pull_request['comments'] = self.pull_request_comments(pull_request['number'])
                                pull_requests.append(pull_request)
                else:
                    pages_exist = False

                page_number = page_number + 1

        return pull_requests

    def pull_request_reviews(self, number, page_range={}):
        reviews = []
        
        if page_range:
            first_page = page_range['first_page']
            last_page = page_range['last_page']

            for page_number in range(first_page, last_page):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/pulls' + '/' + str(number) + '/comments', ['page=' + str(page_number)])

                if request:
                    for review in request:
                        reviews.append(review)
        else:
            pages_exist = True
            page_number = 1

            while(pages_exist):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/pulls' + '/' + str(number) + '/comments', ['page=' + str(page_number)])

                if request:
                    for review in request:
                        reviews.append(review)
                else:
                    pages_exist = False

                page_number = page_number + 1

        return reviews

    def pull_request_comments(self, number, page_range={}):
        comments = []
        
        if page_range:
            first_page = page_range['first_page']
            last_page = page_range['last_page']

            for page_number in range(first_page, last_page):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/issues' + '/' + str(number) + '/comments', ['page=' + str(page_number)])

                if request:
                    for comment in request:
                        comments.append(comment)
        else:
            pages_exist = True
            page_number = 1

            while(pages_exist):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/issues' + '/' + str(number) + '/comments', ['page=' + str(page_number)])

                if request:
                    for comment in request:
                        comments.append(comment)
                else:
                    pages_exist = False

                page_number = page_number + 1

        return comments


    def issues(self, state=None, direction=None, milestone=None, labels=None, creator=None, since=None, assignee=None, mentioned=None, page_range={}):
        print('[Repository] Returning issues available in ' + self.name)

        issues = []
        parameters = []

        if state is not None:
            parameters.append('state=' + state)
        if direction is not None:
            parameters.append('direction=' + direction)
        if labels is not None:
            parameters.append('labels=' + labels)
        if creator is not None:
            parameters.append('creator=' + creator)
        if since is not None:
            parameters.append('since=' + since)
        if milestone is not None:
            parameters.append('milestone=' + milestone)
        if mentioned is not None:
            parameters.append('mentioned=' + mentioned)
        if assignee is not None:
            parameters.append('assignee=' + assignee)

        if page_range:
            first_page = page_range['first_page']
            last_page = page_range['last_page']

            for page_number in range(first_page, last_page):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/issues', parameters + ['page=' + str(page_number)])

                if request:
                    for issue in request:
                        issues.append(issue)
        else:
            pages_exist = True
            page_number = 1

            while(pages_exist):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/issues', parameters + ['page=' + str(page_number)])

                if request:
                    for issue in request:
                        issues.append(issue)
                else:
                    pages_exist = False

                page_number = page_number + 1

        return issues

    def contributors(self, anonymous='false', page_range={}):
        print('[Repository] Returning contributors of ' + self.name)

        contributors = []

        if page_range:
            first_page = page_range['first_page']
            last_page = page_range['last_page']

            for page_number in range(first_page, last_page):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/contributors', ['page=' + str(page_number), 'anon=' + str(anonymous)])

                if request:
                    for contributor in request:
                        contributors.append(contributor)
        else:
            pages_exist = True
            page_number = 1

            while(pages_exist):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/contributors', ['page=' + str(page_number), 'anon=' + str(anonymous)])

                if request:
                    for contributor in request:
                        contributors.append(contributor)
                else:
                    pages_exist = False

                page_number = page_number + 1

        return contributors


    def stars(self, page_range={}):
        print('[Repository] Returning stars available in ' + self.name)

        stars = []
        parameters = []

        if page_range:
            first_page = page_range['first_page']
            last_page = page_range['last_page']

            for page_number in range(first_page, last_page):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/stargazers', parameters + ['page=' + str(page_number)])

                if request:
                    for star in request:
                        stars.append(star)
        else:
            pages_exist = True
            page_number = 1

            while(pages_exist):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/stargazers', parameters + ['page=' + str(page_number)])

                if request:
                    for star in request:
                        stars.append(star)
                else:
                    pages_exist = False

                page_number = page_number + 1

        return stars

    def forks(self, sort=None, page_range={}):
        print('[Repository] Returning forks available in ' + self.name)

        forks = []
        parameters = []

        if sort is not None:
            parameters.append('sort=' + sort)

        if page_range:
            first_page = page_range['first_page']
            last_page = page_range['last_page']

            for page_number in range(first_page, last_page):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/forks', parameters + ['page=' + str(page_number)])

                if request:
                    for fork in request:
                        forks.append(fork)
        else:
            pages_exist = True
            page_number = 1

            while(pages_exist):
                request = self.github.request('repos/' + self.organization + '/' + self.name + '/forks', parameters + ['page=' + str(page_number)])

                if request:
                    for fork in request:
                        forks.append(fork)
                else:
                    pages_exist = False

                page_number = page_number + 1

        return forks
