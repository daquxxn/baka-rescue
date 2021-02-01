// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Mask("Mask", 2D) = "white" {}
		_Distorsion("Distorsion", 2D) = "bump" {}
		_distorsionvvaleur("distorsion vvaleur", Range( 0 , 1)) = 1
		_vitessedeplacement("vitesse deplacement", Range( 0 , 1)) = 1
		_premierechaleur("premiere chaleur", Color) = (1,0,0.01066828,0)
		_chaleur("chaleur", Color) = (1,0.532876,0,0)
		_Float0("Float 0", Range( 0 , 2)) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _premierechaleur;
		uniform float4 _chaleur;
		uniform sampler2D _Mask;
		uniform sampler2D _Distorsion;
		uniform float4 _Distorsion_ST;
		uniform float _distorsionvvaleur;
		uniform float _vitessedeplacement;
		uniform float _Float0;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Distorsion = i.uv_texcoord * _Distorsion_ST.xy + _Distorsion_ST.zw;
			float2 panner12 = ( ( _Time.y * _vitessedeplacement ) * float2( 0,-1 ) + float2( 0,0 ));
			float2 uv_TexCoord10 = i.uv_texcoord + panner12;
			float4 lerpResult18 = lerp( _premierechaleur , _chaleur , tex2D( _Mask, ( ( (UnpackNormal( tex2D( _Distorsion, uv_Distorsion ) )).xy * _distorsionvvaleur ) + uv_TexCoord10 ) ).r);
			float4 temp_cast_0 = (_Float0).xxxx;
			float4 temp_output_22_0 = ( pow( lerpResult18 , temp_cast_0 ) * _Float0 );
			o.Emission = temp_output_22_0.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
404;192;1082;633;1540.356;734.2171;3.584477;False;False
Node;AmplifyShaderEditor.RangedFloatNode;15;-1958.55,478.8483;Inherit;True;Property;_vitessedeplacement;vitesse deplacement;5;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;13;-1905.35,266.2483;Inherit;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;5;-2400.82,24.33085;Inherit;True;Property;_Distorsion;Distorsion;3;0;Create;True;0;0;False;0;92fd99349efc75741a0b1d66c9fb4a15;92fd99349efc75741a0b1d66c9fb4a15;False;bump;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-1676.15,401.6483;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-1988.021,-2.269143;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;12;-1464.979,343.8483;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1553.371,203.6258;Inherit;False;Property;_distorsionvvaleur;distorsion vvaleur;4;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;7;-1648.37,-3.774234;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-1197.179,256.6483;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1206.171,4.025774;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;3;-894.3568,-160.6726;Inherit;True;Property;_Mask;Mask;0;0;Create;True;0;0;False;0;e4cb3880e06c02e49aa9aedc09c38f21;e4cb3880e06c02e49aa9aedc09c38f21;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-880.9793,61.24837;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-573.2767,30.61252;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;16;-799.7778,-631.2472;Inherit;False;Property;_premierechaleur;premiere chaleur;6;0;Create;True;0;0;False;0;1,0,0.01066828,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;17;-798.7778,-433.2472;Inherit;False;Property;_chaleur;chaleur;7;0;Create;True;0;0;False;0;1,0.532876,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;28;-194.0804,-373.4229;Inherit;False;Property;_Float0;Float 0;10;0;Create;True;0;0;False;0;2;1.149166;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;18;-265.4963,-617.204;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;20;187.2392,-618.4952;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;44;1186.183,901.7291;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;29;773.364,-708.8932;Inherit;True;Property;_albedo;albedo;11;0;Create;True;0;0;False;0;7130c16fd8005b546b111d341310a9a4;7130c16fd8005b546b111d341310a9a4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;49;105.9228,799.3451;Inherit;True;Property;_Texture0;Texture 0;2;0;Create;True;0;0;False;0;e4cb3880e06c02e49aa9aedc09c38f21;e4cb3880e06c02e49aa9aedc09c38f21;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;48;440.6608,771.2682;Inherit;True;Property;_TextureSample4;Texture Sample 4;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;57;822.3046,337.1999;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;495.8137,-429.4989;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;24;-4.320727,139.5808;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-570.2114,248.1655;Inherit;True;Property;_TextureSample2;Texture Sample 2;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;1399.898,-152.0183;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;-887.6259,635.6989;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1616.829,910.5143;Inherit;True;Property;_vague;vague;12;0;Create;True;0;0;False;0;0.7797146;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;524.3925,-50.37875;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;30;-8.61879,403.1581;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;-2698.509,658.7123;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,-1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;-550.2114,505.057;Inherit;False;Property;_Bruleintensité;Brule intensité;8;0;Create;True;0;0;False;0;0.5304422;0.4976556;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;39;-1605.23,697.8652;Inherit;True;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-479.3466,680.6213;Inherit;True;Constant;_Divide;Divide;10;0;Create;True;0;0;False;0;1.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;211.9012,1093.01;Inherit;False;Property;_Float2;Float 2;9;0;Create;True;0;0;False;0;0.3212579;0.4976556;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;56;876.3585,1132.152;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;55;889.0791,779.775;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;1413.17,641.2612;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;35;-2008.106,695.5466;Inherit;True;Property;_TextureSample3;Texture Sample 3;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-1272.724,704.3091;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;33;279.3925,252.6212;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;834.7142,-80.25832;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;1580.199,194.2267;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;37;-2428.363,657.92;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;1,-1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;-1176.288,960.4111;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;31;-248.9731,560.544;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;282.766,1268.574;Inherit;True;Constant;_Float1;Float 1;10;0;Create;True;0;0;False;0;1.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;52;513.1396,1148.497;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2093.061,-334.6742;Float;False;True;2;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;13;0
WireConnection;14;1;15;0
WireConnection;6;0;5;0
WireConnection;12;1;14;0
WireConnection;7;0;6;0
WireConnection;10;1;12;0
WireConnection;8;0;7;0
WireConnection;8;1;9;0
WireConnection;11;0;8;0
WireConnection;11;1;10;0
WireConnection;2;0;3;0
WireConnection;2;1;11;0
WireConnection;18;0;16;0
WireConnection;18;1;17;0
WireConnection;18;2;2;1
WireConnection;20;0;18;0
WireConnection;20;1;28;0
WireConnection;44;0;55;0
WireConnection;44;1;56;0
WireConnection;48;0;49;0
WireConnection;57;0;48;1
WireConnection;22;0;20;0
WireConnection;22;1;28;0
WireConnection;24;0;23;1
WireConnection;24;1;25;0
WireConnection;23;0;3;0
WireConnection;23;1;42;0
WireConnection;58;0;22;0
WireConnection;58;1;57;0
WireConnection;42;0;40;0
WireConnection;42;1;43;0
WireConnection;34;0;24;0
WireConnection;34;1;33;0
WireConnection;30;0;23;1
WireConnection;30;1;31;0
WireConnection;39;0;35;0
WireConnection;56;0;48;1
WireConnection;56;1;52;0
WireConnection;55;0;48;1
WireConnection;55;1;52;0
WireConnection;45;0;55;0
WireConnection;45;1;44;0
WireConnection;35;0;5;0
WireConnection;35;1;37;0
WireConnection;40;0;39;0
WireConnection;40;1;41;0
WireConnection;33;0;24;0
WireConnection;33;1;30;0
WireConnection;27;0;22;0
WireConnection;27;1;34;0
WireConnection;53;0;22;0
WireConnection;53;1;45;0
WireConnection;37;0;38;0
WireConnection;31;0;25;0
WireConnection;31;1;32;0
WireConnection;52;0;50;0
WireConnection;52;1;51;0
WireConnection;0;2;22;0
ASEEND*/
//CHKSM=967E8BD34928977175AD0FAABBE1AB5A9A98BC4A