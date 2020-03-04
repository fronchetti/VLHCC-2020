# -*- coding: utf-8 -*-

__author__ =  'Felipe Fronchetti'
__contact__ = 'fronchetti@usp.br'

import multiprocessing
from functools import partial
import telescope.collector as GitHub
import telescope.search as GitHubSearch
import telescope.repository as GitHubRepository
import json
import os

class Parser():
    def __init__(self, repository, folder, collector):
        self.repository = repository
        self.name = repository['name']
        self.owner = repository['owner']['login']
        self.folder = folder
        self.collector = GitHubRepository.Repository(self.owner, self.name, collector)

        if not os.path.exists(self.folder):
            os.makedirs(self.folder)

    def get_about(self):
        if not os.path.isfile(self.folder + '/about.json'):
            about = self.collector.about()

            with open(self.folder + '/about.json', 'w') as about_file:
                json.dump(about, about_file)
        else:
            print(self.repository['name'] + ' already contains an about file. Skipping.')

    def get_languages(self):
        if not os.path.isfile(self.folder + '/languages.json'):
            languages = self.collector.languages()

            with open(self.folder + '/languages.json', 'w') as languages_file:
                json.dump(languages, languages_file)
        else:
            print(self.repository['name'] + ' already contains a languages file. Skipping.')

    def get_stars(self):
        if not os.path.isfile(self.folder + '/stars.json'):
            stars = self.collector.stars()

            with open(self.folder + '/stars.json', 'w') as stars_file:
                json.dump(stars, stars_file)
        else:
            print(self.repository['name'] + ' already contains a stars file. Skipping.')

    def get_forks(self):
        if not os.path.isfile(self.folder + '/forks.json'):
            forks = self.collector.forks()

            with open(self.folder + '/forks.json', 'w') as forks_file:
                json.dump(forks, forks_file)
        else:
            print(self.repository['name'] + ' already contains a forks file. Skipping.')

    def get_commits(self):
        if not os.path.isfile(self.folder + '/commits.json'):
            commits = self.collector.commits()

            with open(self.folder + '/commits.json', 'w') as commits_file:
                json.dump(commits, commits_file)
        else:
            print(self.repository['name'] + ' already contains a commits file. Skipping.')

    def get_pull_requests(self):
        try:
            if not os.path.isfile(self.folder + '/pull_requests.json'):
                pull_requests = self.collector.pull_requests(state='all')

                with open(self.folder + '/pull_requests.json', 'w') as pull_requests_file:
                    json.dump(pull_requests, pull_requests_file)
            else:
                print(self.repository['name'] + ' already contains a pull-requests file. Skipping.')
        except:
            print("Problema nos pull_requests!")
                
    def get_readme(self):
        if not os.path.isfile(self.folder + '/readme.json'):
            readme = self.collector.readme()

            with open(self.folder + '/readme.json', 'w') as readme_file:
                json.dump(readme, readme_file)
        else:
            print(self.repository['name'] + ' already contains a readme file. Skipping.')

    def get_contributing(self):
        if not os.path.isfile(self.folder + '/contributing.json'):
            contributing = self.collector.contributing()

            with open(self.folder + '/contributing.json', 'w') as contributing_file:
                json.dump(contributing, contributing_file)
        else:
            print(self.repository['name'] + ' already contains a contributing file. Skipping.')

    def get_code_of_conduct(self):
        try:
            if not os.path.isfile(self.folder + '/code_of_conduct.json'):
                code_of_conduct = self.collector.code_of_conduct()

                with open(self.folder + '/code_of_conduct.json', 'w') as code_of_conduct_file:
                    json.dump(code_of_conduct, code_of_conduct_file)
            else:
                print(self.repository['name'] + ' already contains a code of conduct file. Skipping.')
        except:
            print("Problema no code of conduct!")

def popular_projects_per_language(languages, dataset_folder, collector):
    search = GitHubSearch.Search(collector)
    repositories = {}

    for language in languages:
        print('Looking for repositories written in: ' + language + '. (Sorted by number of stars)')
        repositories[language] = search.repositories(keywords='language:' + language.lower(), sort='stars')

    with open(dataset_folder + '/projects.json', 'w') as projects_file:
        json.dump(repositories, projects_file)

    return repositories

def repositories_in_parallel(repository, dataset_folder, language):
    print('Collecting data from: ' + repository['name'])
    folder = dataset_folder + '/' + language + '/' + repository['name']
    project = Parser(repository, folder, collector)
    project.get_about()
    project.get_languages()
    project.get_pull_requests()
    project.get_commits()
    project.get_stars()

if __name__ == '__main__':
    api_client_id = str('4161a8257efaea420c94')
    api_client_secret = str('d814ec48927a6bd62c55c058cd028a949e5362d4')
    collector = GitHub.Collector(api_client_id, api_client_secret)
    dataset_folder = '../dataset'
    parallel = multiprocessing.Pool(processes=4)

    if os.path.isfile(dataset_folder + '/projects.json'):
        with open(dataset_folder + '/projects.json', 'r') as projects_file:
            projects = json.load(projects_file)
    else:
        print('File with most popular projects per language does not exist. Generating one.')  

        languages = ['C', 'CoffeeScript', 'Clojure', 'Erlang',
            'Go', 'Haskell', 'Java', 'JavaScript', 'Objective-C',
            'Perl', 'PHP', 'Python', 'Ruby', 'Scala', 'TypeScript']

        projects = popular_projects_per_language(languages, dataset_folder, collector)

    for language in projects.keys():
        repositories = projects[language]['items']
        parallel.map(partial(repositories_in_parallel, dataset_folder=dataset_folder, language=language), repositories)
