import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import ReactTable from 'react-table'
import Time from 'react-time-format'
import { Container } from 'semantic-ui-react'
import DeploymentsApi from './DeploymentsApi'

export default class DeploymentsTable extends Component {

  constructor (props) {
    super()
    this.environmentCol = this.environmentCol.bind(this)
    this.state = {
      loading: true,
    }
    this.api = new DeploymentsApi(props)
    this.api.get(deployments => this.setState({
      data: deployments,
      loading: false,
    }))
  }

  dateCol (d) {
    return <Time value={d.row.date} format="YYYY-MM-DD HH:mm:ss" />
  }

  environmentCol (d) {
    return (
      <span>
        <a title="Where is this deploy?" className="croz_link link" href={d.row.environment_link} target="_blank"><div></div></a>
        { this.api.isSummary() && d.row.available ? <div className="jira_complete">AVAILABLE</div> : '' }
        <Link to={`/environment/${d.row.environment}`}>{d.row.environment}</Link>
      </span>
    )
  }

  branchCol (d) {
    return (
      <span>
        { d.row.jira_links.map(t => <a title="What motivated this deploy?" className="jira_link link" href={t} target="_blank"><div></div></a>) }
        <a href={`https://github.com/bloomfire/app/tree/${d.row.branch}`} target="_blank">{d.row.branch}</a>
      </span>
    )
  }

  commitCol (d) {
    return (
      <span>
        <a title="How does this differ from the HEAD of this branch?" className="diff_ahead_link link" href={`https://github.com/bloomfire/app/compare/${d.row.commit}...${d.row.branch}`} target="_blank"><div></div></a>
        <a title="What changed in this deploy?" className="diff_link link" href={`https://github.com/bloomfire/app/compare/${d.row.prev_commit}...${d.row.commit}`} target="_blank"><div></div></a>
        <a href={`https://github.com/bloomfire/app/commit/${d.row.commit}`} target="_blank">{d.row.commit.substring(0, 8)}</a>
      </span>
    )
  }

  userCol (d) {
    return <Link to={`/user/${d.row.user}`}>{d.row.user}</Link>
  }

  columns () {
    return [{
      header: 'Date',
      accessor: 'date',
      render: this.dateCol,
      minWidth: 100,
      width: 150,
    }, {
      header: 'Environment',
      accessor: 'environment',
      render: this.environmentCol,
      width: 200,
    }, {
      header: 'Branch',
      accessor: 'branch',
      render: this.branchCol,
    }, {
      header: 'Commit',
      accessor: 'commit',
      render: this.commitCol,
      width: 150,
      minWidth: 100,
    }, {
      header: 'User',
      accessor: 'user',
      render: this.userCol,
      width: 150,
      minWidth: 100,
    }]
  }

  render () {
    return (
      <Container fluid className="deployments-table">
        <ReactTable
          data={this.state.data}
          loading={!this.state.data}
          columns={this.columns()}
          showPagination={false}
          pageSize={this.state.data ? this.state.data.length : 10}
          defaultSorting={[{ id: 'date', desc: true }]}
          className="-striped -highlight"
        />
      </Container>
    )
  }

}
