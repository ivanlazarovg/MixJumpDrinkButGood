// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Liquid"
{
	Properties
	{
		_Speed("Speed", Float) = 3.05
		_ColorSolid("ColorSolid", Color) = (0.2641509,0.1084016,0.1084016,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_transparency("transparency", Float) = 4
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_RefractAmount("RefractAmount", Float) = 0.18
		_Tiling("Tiling", Float) = 0
		_Float0("Float 0", Float) = 0
		_Length("Length", Float) = 0.005
		_TilingFoam("TilingFoam", Float) = 0
		_Min("Min", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		GrabPass{ }
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf StandardCustomLighting alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float4 screenPos;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _TextureSample0;
		uniform float _TilingFoam;
		uniform float _Speed;
		uniform float _Length;
		uniform float4 _ColorSolid;
		uniform float _transparency;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform sampler2D _TextureSample1;
		uniform float _Float0;
		uniform float _Tiling;
		uniform float _RefractAmount;
		uniform float4 _Min;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 temp_cast_7 = (_TilingFoam).xx;
			float2 uv_TexCoord21 = i.uv_texcoord * temp_cast_7;
			float mulTime5 = _Time.y * _Speed;
			float3 ase_worldPos = i.worldPos;
			float4 transform3 = mul(unity_WorldToObject,float4( 0,0,0,1 ));
			float4 break10 = ( float4( ase_worldPos , 0.0 ) - transform3 );
			float temp_output_11_0 = ( ( sin( ( mulTime5 + break10.x ) ) * 0.01 ) + ( break10.y * 0.2 ) );
			float temp_output_15_0 = step( temp_output_11_0 , 0.0 );
			float4 color70 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 temp_cast_10 = (_Float0).xx;
			float2 temp_cast_11 = (_Tiling).xx;
			float2 uv_TexCoord43 = i.uv_texcoord * temp_cast_11;
			float2 panner44 = ( 0.43 * _Time.y * temp_cast_10 + uv_TexCoord43);
			float4 screenColor27 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( float4( (ase_grabScreenPosNorm).xy, 0.0 , 0.0 ) + ( tex2D( _TextureSample1, panner44 ) * _RefractAmount ) ).rg);
			float4 clampResult51 = clamp( screenColor27 , float4( 0,0,0,0 ) , _Min );
			float4 temp_output_23_0 = ( ( ( tex2D( _TextureSample0, uv_TexCoord21 ).g * ( step( temp_output_11_0 , _Length ) - temp_output_15_0 ) ) * color70 ) + ( temp_output_15_0 * ( ( _ColorSolid * ( _transparency * saturate( clampResult51 ) ) ) + _ColorSolid ) ) );
			c.rgb = 0;
			c.a = temp_output_23_0.r;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			float2 temp_cast_0 = (_TilingFoam).xx;
			float2 uv_TexCoord21 = i.uv_texcoord * temp_cast_0;
			float mulTime5 = _Time.y * _Speed;
			float3 ase_worldPos = i.worldPos;
			float4 transform3 = mul(unity_WorldToObject,float4( 0,0,0,1 ));
			float4 break10 = ( float4( ase_worldPos , 0.0 ) - transform3 );
			float temp_output_11_0 = ( ( sin( ( mulTime5 + break10.x ) ) * 0.01 ) + ( break10.y * 0.2 ) );
			float temp_output_15_0 = step( temp_output_11_0 , 0.0 );
			float4 color70 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 temp_cast_3 = (_Float0).xx;
			float2 temp_cast_4 = (_Tiling).xx;
			float2 uv_TexCoord43 = i.uv_texcoord * temp_cast_4;
			float2 panner44 = ( 0.43 * _Time.y * temp_cast_3 + uv_TexCoord43);
			float4 screenColor27 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( float4( (ase_grabScreenPosNorm).xy, 0.0 , 0.0 ) + ( tex2D( _TextureSample1, panner44 ) * _RefractAmount ) ).rg);
			float4 clampResult51 = clamp( screenColor27 , float4( 0,0,0,0 ) , _Min );
			float4 temp_output_23_0 = ( ( ( tex2D( _TextureSample0, uv_TexCoord21 ).g * ( step( temp_output_11_0 , _Length ) - temp_output_15_0 ) ) * color70 ) + ( temp_output_15_0 * ( ( _ColorSolid * ( _transparency * saturate( clampResult51 ) ) ) + _ColorSolid ) ) );
			o.Emission = temp_output_23_0.rgb;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
219;81;1142;579;-840.0699;-93.12637;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;48;-1463.373,1403.883;Inherit;False;Property;_Tiling;Tiling;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-1289.968,1389.507;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;49;-1286.062,1529.143;Inherit;False;Property;_Float0;Float 0;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;44;-1026.969,1431.707;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0.25,0.34;False;1;FLOAT;0.43;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldToObjectTransfNode;3;-1366.249,232.1314;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-1516.026,-33.72125;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GrabScreenPosition;24;-739.1528,968.8718;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;47;-632.6429,1239.008;Inherit;False;Property;_RefractAmount;RefractAmount;5;0;Create;True;0;0;False;0;0.18;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;-1135.249,-10.86856;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1377.893,-264.2066;Inherit;False;Property;_Speed;Speed;0;0;Create;True;0;0;False;0;3.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;-756.0403,1445.907;Inherit;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;True;0;0;False;0;-1;e9742c575b8f4644fb9379e7347ff62e;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;5;-1025.809,-219.9248;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;10;-836.4875,207.1982;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-393.1884,1221.552;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;50;-479.634,975.4426;Inherit;True;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-711.2986,-63.79303;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-215.2069,1109.164;Inherit;True;2;2;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;72;197.417,1353.389;Inherit;False;Property;_Min;Min;10;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;27;-3.333637,1101.079;Inherit;False;Global;_GrabScreen0;Grab Screen 0;4;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;9;-426.8972,-32.56636;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;51;212.0524,1161.363;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-225.5865,39.18991;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-524.9296,268.3935;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;49.66052,-36.60976;Inherit;False;Property;_TilingFoam;TilingFoam;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;17.68237,111.8023;Inherit;False;Property;_Length;Length;8;0;Create;True;0;0;False;0;0.005;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-107.9543,212.6153;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;293.8152,901.9534;Inherit;False;Property;_transparency;transparency;3;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;28;332.3654,1048.905;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;18;316.0906,676.9532;Inherit;False;Property;_ColorSolid;ColorSolid;1;0;Create;True;0;0;False;0;0.2641509,0.1084016,0.1084016,0;0.4056604,0.2617975,0.2315326,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;219.1871,-40.56882;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;14;215.6205,87.96381;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;544.9331,967.2672;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;15;222.1384,356.5035;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;16;498.2042,213.5304;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;19;512.3953,13.51721;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;662.8134,825.4658;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;70;844.886,404.7585;Inherit;False;Constant;_Color0;Color 0;10;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;66;821.0245,668.2465;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;823.3589,214.1142;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;933.8532,481.2692;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;1022.986,309.8586;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;1157.288,313.697;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;74;1533.622,178.543;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;Liquid;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;43;0;48;0
WireConnection;44;0;43;0
WireConnection;44;2;49;0
WireConnection;4;0;1;0
WireConnection;4;1;3;0
WireConnection;45;1;44;0
WireConnection;5;0;7;0
WireConnection;10;0;4;0
WireConnection;46;0;45;0
WireConnection;46;1;47;0
WireConnection;50;0;24;0
WireConnection;8;0;5;0
WireConnection;8;1;10;0
WireConnection;33;0;50;0
WireConnection;33;1;46;0
WireConnection;27;0;33;0
WireConnection;9;0;8;0
WireConnection;51;0;27;0
WireConnection;51;2;72;0
WireConnection;12;0;9;0
WireConnection;13;0;10;1
WireConnection;11;0;12;0
WireConnection;11;1;13;0
WireConnection;28;0;51;0
WireConnection;21;0;68;0
WireConnection;14;0;11;0
WireConnection;14;1;67;0
WireConnection;65;0;36;0
WireConnection;65;1;28;0
WireConnection;15;0;11;0
WireConnection;16;0;14;0
WireConnection;16;1;15;0
WireConnection;19;1;21;0
WireConnection;63;0;18;0
WireConnection;63;1;65;0
WireConnection;66;0;63;0
WireConnection;66;1;18;0
WireConnection;22;0;19;2
WireConnection;22;1;16;0
WireConnection;17;0;15;0
WireConnection;17;1;66;0
WireConnection;69;0;22;0
WireConnection;69;1;70;0
WireConnection;23;0;69;0
WireConnection;23;1;17;0
WireConnection;74;2;23;0
WireConnection;74;9;23;0
ASEEND*/
//CHKSM=A0E7BE682A2AF5F18273699D99E67379589847CF