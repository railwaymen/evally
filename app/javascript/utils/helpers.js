export const pluckUniq = (arr, attribute) => (
  _.filter(_.uniq(_.map(arr, attribute)), Boolean)
)
