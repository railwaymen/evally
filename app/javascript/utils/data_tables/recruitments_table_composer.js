export default class RecruitmentsTableComposer {
  static requestQuery(options) {
    return {
      per_page: options.itemsPerPage,
      page: options.page,
      sort_by: options.sortBy[0] || 'received_at',
      sort_dir: options.sortDesc[0] ? 'desc' : 'asc',
      "filters[group]": options.group || '',
      "filters[status]": options.status || '',
      "filters[evaluator_token]": options.evaluatorToken || '',
      search: options.search || ''
    }
  }

  static tableOptions(params) {
    return {
      page: Number(params.page) || 1,
      itemsPerPage: Number(params.per_page) || 25,
      sortBy: params.sort_by ? [params.sort_by] : ['received_at'],
      sortDesc: params.sort_by ? [params.sort_dir === 'desc'] : [true],
      group: params["filters[group]"] || '',
      status: params["filters[status]"] || '',
      evaluatorToken: params["filters[evaluator_token]"] || '',
      search: params.search || ''
    }
  }
}
