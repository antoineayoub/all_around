var Inbox = React.createClass({
  getInitialState: function() {
    return {
      conversations: this.props.conversations,
      selectedConversationId: this.props.request_id,
      firstName: this.props.first_name,
      messages: this.props.messages
    }
  },

  render: function() {
    return (
      <div className="container">
        <div className="row">
          <div className="col-sm-4" id="conversation-list">
            <div className="panel panel-default">
              <div className="panel-heading">
                <h4>Inbox</h4>
              </div>
              <div className="panel-body fixed-height">
                <ConversationList
                  conversations={this.state.conversations}
                  selectedConversationId={this.state.selectedConversationId}
                  onConversationSelection={this.handleConversationSelection}
                  />
              </div>
            </div>
          </div>
          <div className="col-sm-8" id="message-list">
            <div className="panel panel-default">
              <div className="panel-heading">
                <h4>{this.state.firstName}</h4>
              </div>
              <div className="panel-body fixed-height">
                <div className="wrapper">
                  <MessageList messages={this.state.messages}/>
                  <CreateMessage conversationId={this.state.selectedConversationId} ref='textarea' onMessageCreation={this.handleMessageCreation}/>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  },

  handleConversationSelection: function(id) {
    var that = this
    $.ajax({
      type: 'GET',
      url: Routes.conversations_path({format: 'json', request_id: id}),
      success: function(data) {
        that.setState({
          conversations: data.conversations,
          selectedConversationId: data.request_id,
          firstName: data.first_name,
          messages: data.messages
        })
        that.refs.textarea.setState({
          focused: false
        })
        $('.wrapper').css('padding-bottom', 61)
        setTimeout(function() {
          $('.wrapper').animate({
            scrollTop: $('.messages').height()
          }, "slow");
        }, 50)
      }
    })
  },

  handleMessageCreation: function(conversationId, content) {
    var that = this
    $.ajax({
      type: 'POST',
      url: Routes.request_message_path({format: 'json', request_id: conversationId, message: {content: content}}),
      success: function(data) {
        that.setState({
          conversations: data.conversations,
          selectedConversationId: data.request_id,
          firstName: data.first_name,
          messages: data.messages
        })
        $('.wrapper').css('padding-bottom', 61)
      }
    })
  },

  componentDidMount: function() {
    $('.wrapper').scrollTop($('.wrapper')[0].scrollHeight)
  }
})
