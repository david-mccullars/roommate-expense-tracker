import React, { Component } from 'react'
import { Container } from 'semantic-ui-react'

export default class Footer extends Component {

  render () {
    return this.props.login ? (
      <Container fluid className="expenses-footer">
        <footer className="page__footer">
          debtor, debtee, amount = summary # NOTE: We currently only support 2 logins
          if debtor
            <h1 className="owes"> debtor.titleize  owes  debtee.titleize   number_to_currency(amount) </h1>
          elsif @expenses.values.any?(&:present?)
            <h1 className="paidup">Month has been paid up.</h1>
          end
        </footer>
      </Container>
    ) : null
  }

}
