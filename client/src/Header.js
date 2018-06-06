import React, { Component } from 'react'
import { Container } from 'semantic-ui-react'

export default class Header extends Component {

  loggedInHeader () {
    return (
      <Container fluid className="expenses-header">
        <header className="page__header">
          <NewExpenseForm />
          <div id="logged_in_as">
            Hello, <b>{this.props.login.name}</b> <a href="javascript:TODO">[Logout]</a><br/>
          </div>
          <button className="prev" type="button" href="?month= (@month - 1.month).strftime(%Y%m)">&lt;</button>
          @month.strftime("%B, %Y")
          <button className="next" type="button" href="?month= (@month + 1.month).strftime(%Y%m)">&gt;</button>
        </header>
      </Container>
    )
  }

  loggedOutHeader () {
    return (
      <Container fluid className="expenses-header">
        <header className="page__header">
          <div id="logged_in_as">
            {document.title}
          </div>
        </header>
      </Container>
    )
  }

  render () {
    return this.props.login ? this.loggedInHeader() : this.loggedOutHeader()
  }

}
