package sprinter.game 
{
	import loom.gameframework.AnimatedComponent;
	import loom2d.display.DisplayObjectContainer;
	import loom2d.math.Point;
	import loom2d.math.Rectangle;
	import loom2d.ui.TextureAtlasSprite;
	
	public class RenderComponent extends AnimatedComponent
	{
		private var _parent: DisplayObjectContainer;
		private var _spawnCoordinates: Point;
		private var _textureName: String;
		private var _texture: TextureAtlasSprite;
		
		public function RenderComponent(parent: DisplayObjectContainer,
										spawnCoordinates: Point,
										textureName: String)
		{
			_parent = parent;
			_spawnCoordinates = spawnCoordinates;
			_textureName = textureName;
		}
		
		protected function onAdd(): Boolean
		{
			if (!super.onAdd())
				return false;
			
			_texture = new TextureAtlasSprite();
			_texture.atlasName = "sprinterSprites";
			_texture.textureName = _textureName;
			_texture.center();
			_texture.x = _spawnCoordinates.x;
			_texture.y = _spawnCoordinates.y;
			
			_parent.addChild(_texture);
			return true;
		}
		
		protected function onRemove()
		{
			_parent = null;
			
			super.onRemove();
		}
		
		public function set position(value: Point)
		{
			_texture.x = value.x;
			_texture.y = value.y;
		}
		
		public function set scaleX(value: Number)
		{
			_texture.scaleX = value;
		}
		
		public function get hitbox(): Rectangle { return _texture ? _texture.bounds : new Rectangle(0, 0, 0, 0); }
	}
	
}