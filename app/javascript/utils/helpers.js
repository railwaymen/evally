import filter from 'lodash/filter'
import map from 'lodash/map'
import range from 'lodash/range'
import uniq from 'lodash/uniq'

export const pluckUniq = (arr, attribute) => (
  filter(uniq(map(arr, attribute)), Boolean)
)

export const getURLParams = payload => (
  new URLSearchParams(payload).toString()
)

export const fetchError = ({ response }) => {
  if (typeof response.data !== 'object') return response.statusText

  const details = response.data.details.join(', ')
  return details !== '' ? details : response.data.message
}

export const linksToIcons = linksArr => (
  linksArr.map(link => {
    const matcher = link.trim().match(
      /^https?:\/\/.*(linkedin\.com|github\.com|gitlab\.com|bitbucket\.org)\/.+$/
    )

    if (!matcher) return 'mdi-link-variant'

    switch (matcher[1].split('.')[0]) {
      case 'linkedin':
        return 'mdi-linkedin'
      case 'github':
        return 'mdi-github'
      case 'gitlab':
        return 'mdi-gitlab'
      case 'bitbucket':
        return 'mdi-bitbucket'
      default:
        return 'mdi-link-variant'
    }
  })
)

export const objectToFormData = (obj, namespace, form = new FormData()) => {
  let formKey

  for(let property in obj) {
    // eslint-disable-next-line
    if(obj.hasOwnProperty(property)) {
      if (namespace) {
        formKey = namespace + '[' + property + ']'
      } else {
        formKey = property
      }

      if ([null, undefined, ''].includes(obj[property])) {
        // WTF: typeof null -> object?
        form.append(formKey, '')
      } else if (typeof obj[property] === 'object' && !(obj[property] instanceof File) && !(obj[property] instanceof Array)) {
        // if the property is an object, but not a File, use recursivity.
        objectToFormData(obj[property], formKey, form)
      } else {
        // if it's a string or a File object
        form.append(formKey, obj[property])
      }
    }
  }

  return form
}

export const arrayRange = (start = 0, end, step = 1) => range(start, end, step)

export const colors = [
  '#EF5350',
  '#EC407A',
  '#AB47BC',
  '#7E57C2',
  '#5C6BC0',
  '#42A5F5',
  '#29B6F6',
  '#26C6DA',
  '#26A69A',
  '#66BB6A',
  '#9CCC65',
  '#D4E157',
  '#FFEE58',
  '#FFCA28',
  '#FFA726',
  '#FF7043',
  '#8D6E63',
  '#78909C',
  '#C62828',
  '#AD1457',
  '#6A1B9A',
  '#4527A0',
  '#283593',
  '#1565C0',
  '#0277BD',
  '#00838F',
  '#00695C',
  '#2E7D32',
  '#558B2F',
  '#9E9D24',
  '#F9A825',
  '#FF8F00',
  '#EF6C00',
  '#D84315',
]
