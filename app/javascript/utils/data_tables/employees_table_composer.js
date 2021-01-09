export default class EmployeesTableComposer {
  static requestQuery(options) {
    return {
      per_page: options.itemsPerPage,
      page: options.page,
      sort_by: options.sortBy[0] || 'last_name',
      sort_dir: options.sortDesc[0] ? 'desc' : 'asc',
      "filters[group]": options.group || '',
      "filters[evaluator_id]": options.evaluatorId || '',
      search: options.search || ''
    }
  }

  static tableOptions(params) {
    return {
      page: Number(params.page) || 1,
      itemsPerPage: Number(params.per_page) || 25,
      sortBy: params.sort_by ? [params.sort_by] : ['last_name'],
      sortDesc: params.sort_by ? [params.sort_dir === 'desc'] : [false],
      group: params["filters[group]"] || '',
      evaluatorId: Number(params["filters[evaluator_id]"]) || '',
      search: params.search || ''
    }
  }
}
