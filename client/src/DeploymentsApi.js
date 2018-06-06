export default class DeploymentsApi {

  constructor (props) {
    this.props = props
    this.jwtToken = window.sessionStorage.getItem('jwtToken') || ''
    this.limit = this.props.limit ? `?limit=${this.props.limit}` : ''
  }

  endpoint () {
    if (this.props.environment) {
      return `/api/environment/${this.props.environment}`
    } else if (this.props.user) {
      return `/api/user/${this.props.user}`
    } else {
      return `/api/summary`
    }
  }

  isLog () {
    return this.props.environment || this.props.user
  }

  isSummary () {
    return !this.isLog()
  }

  get (onData) {
    fetch(this.endpoint() + this.limit, this.getOptions())
        .then(response => {
          return response.json().then(json => ({ status: response.status, json: json }))
        })
        .catch(error => console.log(error))
        .then(({status, json}) => {
          if (status === 200) {
            onData(json.deployments)
          } else if (status === 401 && json.saml_login_url) {
            location.href = json.saml_login_url
          } else {
            console.debug("API ERROR", status, json)
          }
        })
  }

  getOptions () {
    return {
      method: 'GET',
      headers: {
        'Content-Type': 'text/json',
        'Authorization': `Token ${this.jwtToken}`,
      },
      mode: 'cors',
      cache: 'default',
    }
  }

}
