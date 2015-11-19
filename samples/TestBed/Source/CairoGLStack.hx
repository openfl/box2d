package;

import lime.graphics.Image;
import lime.graphics.PixelFormat;
import lime.graphics.cairo.Cairo;
import lime.graphics.cairo.CairoImageSurface;
import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLTexture;
import lime.utils.Float32Array;
import lime.utils.GLUtils;

class CairoGLStack {
    
    var glBuffer:GLBuffer;
    var glProgram:GLProgram;
    var glTexture:GLTexture;
    var glVertexAttribute:Int;
    var image:Image;
    var surface:CairoImageSurface;
    public var cairo(default, null):Cairo;
    var vertexPosition:Int;

    public function new() {
        image = new Image(null, 0, 0, 1, 1);
        image.format = PixelFormat.RGBA32;
        surface = CairoImageSurface.fromImage(image);
        cairo = new Cairo(surface);

        var vertexSource = '
            attribute vec2 aPos;
            varying vec2 vUV;
            
            void main(void) {
                vUV = vec2(aPos.x * .5 + .5, -aPos.y * .5 + .5);
                gl_Position = vec4(aPos, 1., 1.);
            }
            ';
        
        var fragmentSource = #if !desktop 'precision mediump float;' + #end '
            varying vec2 vUV;
            uniform sampler2D uSampler;
            
            void main(void)
            {
                gl_FragColor = texture2D(uSampler, vUV);
            }
            ';
        
        glProgram = GLUtils.createProgram(vertexSource, fragmentSource);
        GL.useProgram(glProgram);
        
        glVertexAttribute = GL.getAttribLocation(glProgram, 'aPos');
        var imageUniform = GL.getUniformLocation(glProgram, 'uSampler');
        
        GL.enableVertexAttribArray(glVertexAttribute);
        GL.uniform1i(imageUniform, 0);
        
        GL.blendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);
        GL.enable(GL.BLEND);
        
        var data = [
             1,  1,
            -1,  1,
             1, -1,
            -1, -1,
        ];
        
        glBuffer = GL.createBuffer();
        GL.bindBuffer(GL.ARRAY_BUFFER, glBuffer);
        GL.bufferData(GL.ARRAY_BUFFER, new Float32Array(data), GL.STATIC_DRAW);
        GL.bindBuffer(GL.ARRAY_BUFFER, null);
        
        glTexture = GL.createTexture();
        GL.bindTexture(GL.TEXTURE_2D, glTexture);
        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);
        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
        GL.bindTexture(GL.TEXTURE_2D, null);
    }

    public function setSize(width, height) {
        image.resize(width, height);
        surface = CairoImageSurface.fromImage(image);
        @:privateAccess cairo.recreate(surface);
    }

    public function render():Void {
        GL.bindTexture(GL.TEXTURE_2D, glTexture);
        image.format = PixelFormat.RGBA32;
        GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA, image.width, image.height, 0, GL.RGBA, GL.UNSIGNED_BYTE, image.data);
        image.format = PixelFormat.BGRA32;
        GL.bindTexture(GL.TEXTURE_2D, null);

        GL.viewport(0, 0, image.width, image.height);
        
        GL.clearColor(0, 0, 0, 1);
        GL.clear(GL.COLOR_BUFFER_BIT);
        
        GL.activeTexture(GL.TEXTURE0);
        GL.bindTexture(GL.TEXTURE_2D, glTexture);
        
        #if desktop GL.enable(GL.TEXTURE_2D); #end
        
        GL.bindBuffer(GL.ARRAY_BUFFER, glBuffer);
        GL.vertexAttribPointer(glVertexAttribute, 2, GL.FLOAT, false, 2 * Float32Array.BYTES_PER_ELEMENT, 0);
        
        GL.drawArrays(GL.TRIANGLE_STRIP, 0, 4);
    }
}
