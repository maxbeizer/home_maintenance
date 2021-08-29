# home_maintenance

A project to help create automated issues related to home maintenance tasks.

This is a GitHub Action that will create issues in a specified repo for various
seasonal home maintenance tasks. Install the action where you keep track of such
things and have it run daily. The action will loop through a CSV of various
tasks and open, for example, springtime tasks on the first day of spring.

## Example configuration

```yaml
# in .github/workflows/home_maintenance.yml
on:
  schedule:
    # * is a special character in YAML so you have to quote this string
    # Run daily at 0100h
    - cron:  '0 1 * * *'

jobs:
  maintenance:
    runs-on: ubuntu-latest
    name: create maintenance issues
    steps:
      # Assumes you want to supply your own csv from your destination repo.
      # Check the tasks.csv file in this repo for required structure.
      # If you want to use the tasks from this repo, no need to checkout and
      # omit the path-to-data input below.
      - name: Checkout
        uses: actions/checkout@v2
      - name: home_maintenance_action
        uses: maxbeizer/home_maintenance@main
        with:
          repo-nwo: 'maxbeizer/my-cool-repo'
          github-token: ${{ secrets.GITHUB_TOKEN }}
          path-to-data: 'data/tasks.csv'
```

## Credit

The CSV of tasks was originally shared with me by
[@jjcaine](https://github.com/jjcaine) :sparkling_heart:

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/maxbeizer/home_maintenance. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to adhere
to the [code of conduct](https://github.com/maxbeizer/home_maintenance/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the HomeMaintenance project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/maxbeizer/home_maintenance/blob/master/CODE_OF_CONDUCT.md).

## License

MIT
