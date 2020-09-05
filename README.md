# departure-times

## Table of contents

- [Introduction](https://github.com/santiago-rodrig/departure-times#introduction)
- [Live version and API documentation](https://github.com/santiago-rodrig/departure-times#collaboration)
- [Setup in local environment](https://github.com/santiago-rodrig/departure-times#live-version-and-api-documentation)
- [Collaboration](https://github.com/santiago-rodrig/departure-times#license)
- [Contact](https://github.com/santiago-rodrig/departure-times#contact)

### Introduction

This project is an API for fetching data about the departure times (obviously!)
of the public transport in a given bus stop, the data is being fetched from the
[NextBus API](https://www.nextbus.com/xmlFeedDocs/NextBusXMLFeed.pdf).

Right now, only one agency is being taken into account,
this agency is [San Francisco Muni](https://www.sfmta.com/). Actually, all the
public transport agencies that are in the North of California should be
handled, that's for a future version of the API.

### Live version and API documentation

The live version of the API has the following base URL.

`https://srodrig-departure-time-api.herokuapp.com/api/v1/`

All the possible endpoints are explained in
[the documentation](https://documenter.getpostman.com/view/11766934/TVCh1TUJ).

## Setup in local environment

First and foremost, you'll need to have the following.

- [Ruby](https://www.ruby-lang.org/en/) (~> 2.6.6)

Now, clone the repository.

```sh
git clone https://github.com/santiago-rodrig/departure-time.git
```

Install the dependencies.

```sh
bundle install
```

And you're set, to run the tests use `rake test`, to start the local web server
use `rake server`.

## Collaboration

To collaborate to this project first fork the repository, after that, create a new branch based
on
[develop](https://github.com/santiago-rodrig/departure-times/tree/develop)
(using [Git-flow](https://nvie.com/posts/a-successful-git-branching-model/)
is recommended), push your branch to your forked repository and create a PR (Pull Request)
from your branch to the develop branch of the original repository.

## License

Specify the license. You can [read the license here](./LICENSE.md).

## Contact

You can reach out to me through the following URLs.

- [My website](https://santiagorodriguez.dev)
- [Github](https://github.com/santiago-rodrig)
- [LinkedIn](https://www.linkedin.com/in/santiago-andres-rodriguez-marquez/)
- [AngelList](https://angel.co/u/santiago-andres-rodriguez-marquez)
- [santo1996.29@gmail.com](mailto:santo1996.29@gmail.com)