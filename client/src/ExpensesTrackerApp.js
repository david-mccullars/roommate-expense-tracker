import React, { Component } from 'react'
import { Container, Dimmer, Loader } from 'semantic-ui-react'
import DeploymentsTable from './DeploymentsTable'
import Header from './Header'
import Footer from './Footer'

export default class ExpensesTrackerApp extends Component {

  renderLoading () {
    return (
      <Container fluid>
        <Header/>
        <Loader>Loading</Loader>
      </Container>
    )
  }

  renderLogin () {
    return (
      <Container fluid>
        <Header/>
      </Container>
    )
  }

  renderExpenses () {
    return (
      <Container fluid>
        <Header />
        <Footer />
      </Container>
    )
  }

  render () {
    return this.renderLoading()
  }

}
