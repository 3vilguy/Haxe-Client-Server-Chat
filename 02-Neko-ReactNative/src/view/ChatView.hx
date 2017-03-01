package view;

import react.ReactComponent;
import react.ReactMacro.jsx;
import react.native.api.*;
import react.native.component.*;

class ChatView extends ReactComponentOfProps<ChatViewProps>
{
	public function new(props:ChatViewProps) 
	{
		super(props);
	}

	override public function render():ReactElement 
	{
		return jsx('
			<ScrollView contentContainerStyle={{flex: 1, justifyContent: "flex-end"}}>
				${createChatMessages()}
			</ScrollView>
		');
	}
	
	private function createChatMessages():Array<ReactElement>
	{
		if (props.messages.length > 0)
		{
			return [for (i in 0...props.messages.length) jsx('<Text key=$i>${props.messages[i]}</Text>')];
		}
		return null;
	}
}

typedef ChatViewProps = {
	messages : Array<String>
}