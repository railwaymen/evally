export default class UsersTableComposer {
  static requestQuery(options) {
    return {
      per_page: options.itemsPerPage,
      page: options.page,
      sort_by: options.sortBy[0] || 'last_name',
      sort_dir: options.sortDesc[0] ? 'desc' : 'asc',
      search: options.search || ''
    }
  }

  static tableOptions(params) {
    return {
      page: Number(params.page) || 1,
      itemsPerPage: Number(params.per_page) || 25,
      sortBy: params.sort_by ? [params.sort_by] : ['last_name'],
      sortDesc: params.sort_by ? [params.sort_dir === 'desc'] : [false],
      search: params.search || ''
    }
  }
}
