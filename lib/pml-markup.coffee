PmlMarkupView = require './pml-markup-view'
{CompositeDisposable} = require 'atom'

module.exports = PmlMarkup =
  pmlMarkupView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @pmlMarkupView = new PmlMarkupView(state.pmlMarkupViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @pmlMarkupView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'pml-markup:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @pmlMarkupView.destroy()

  serialize: ->
    pmlMarkupViewState: @pmlMarkupView.serialize()

  toggle: ->
    console.log 'PmlMarkup was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
