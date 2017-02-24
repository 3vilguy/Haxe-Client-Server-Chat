package view;

import react.ReactComponent;
import react.ReactMacro.jsx;

class ChatView extends ReactComponentOfProps<ChatViewProps>
{
	public function new(props:ChatViewProps) 
	{
		super(props);
	}
	
	override public function render():ReactElement 
	{
		return jsx('
			<div>
				${createChatMessages()}
			<div/>
		');
	}
	
	private function createChatMessages():Array<ReactElement>
	{
		if (props.messages.length > 0)
		{
			return [for (msg in props.messages) jsx('<div>$msg<div />')];
		}
		return null;
	}
}

typedef ChatViewProps = {
	messages : Array<String>
}