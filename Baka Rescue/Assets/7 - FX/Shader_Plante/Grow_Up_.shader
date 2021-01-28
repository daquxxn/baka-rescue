// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Shader_Plante_Grow"
{
	Properties
	{
		_Scale_And_Offset("Scale_And_Offset", Range( 0 , 1)) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_01("01", 2D) = "white" {}
		_02("02", 2D) = "white" {}
		_Float1("Float 1", Range( 0 , 1)) = 0.7590939
		_Float2("Float 2", Range( 0 , 1)) = 0.4948296
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _01;
		uniform sampler2D _02;
		uniform float4 _02_ST;
		uniform float _Float1;
		uniform float _Float2;
		uniform float _Scale_And_Offset;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float2 uv_02 = i.uv_texcoord * _02_ST.xy + _02_ST.zw;
			float temp_output_22_0 = ( _Time.y * _Float2 );
			float2 panner18 = ( temp_output_22_0 * float2( 0,0 ) + float2( 0,0 ));
			float2 uv_TexCoord17 = i.uv_texcoord + panner18;
			float4 smoothstepResult7 = smoothstep( float4( 0,0,0,0 ) , float4( 1,0,0,0 ) , ( tex2D( _TextureSample0, uv_TextureSample0 ) * tex2D( _01, ( ( (UnpackNormal( tex2D( _02, uv_02 ) )).xy * _Float1 ) + uv_TexCoord17 ) ) ));
			float4 temp_cast_0 = ((_Scale_And_Offset*1.0 + 0.0)).xxxx;
			clip( smoothstepResult7 - temp_cast_0);
			o.Emission = tex2D( _TextureSample1, uv_TextureSample1 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
2;480;1434;275;1687.405;-151.7818;1;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;20;-3159.593,597.3503;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-3254.916,694.9095;Inherit;False;Property;_Float2;Float 2;8;0;Create;True;0;0;False;0;0.4948296;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;12;-3549.775,166.3111;Inherit;True;Property;_02;02;5;0;Create;True;0;0;False;0;61c0b9c0523734e0e91bc6043c72a490;61c0b9c0523734e0e91bc6043c72a490;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;13;-3219.238,178.7453;Inherit;True;Property;_TextureSample5;Texture Sample 2;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-2973.019,626.0701;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-2881.657,376.9687;Inherit;False;Property;_Float1;Float 1;6;0;Create;True;0;0;False;0;0.7590939;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;14;-2875.855,176.041;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;18;-2819.142,577.5549;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-2618.064,560.686;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-2606.531,349.1309;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-2347.311,423.8132;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;11;-1968.711,547.8647;Inherit;True;Property;_01;01;4;0;Create;True;0;0;False;0;153f0c19c3abd7241b56732f387a2f39;153f0c19c3abd7241b56732f387a2f39;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;3;-1561.69,-87.45486;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;153f0c19c3abd7241b56732f387a2f39;153f0c19c3abd7241b56732f387a2f39;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-1570.113,389.6093;Inherit;True;Property;_TextureSample3;Texture Sample 2;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2;-1005.254,178.0868;Inherit;False;Property;_Scale_And_Offset;Scale_And_Offset;1;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1250.022,56.00827;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;5;-1007.255,-506.8476;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;False;0;84508b93f15f2b64386ec07486afc7a3;84508b93f15f2b64386ec07486afc7a3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;1;-741.9197,185.022;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;7;-736.4282,-85.96387;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;10;-1622.113,604.9047;Inherit;True;Property;_TextureSample4;Texture Sample 2;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-3156.382,841.6823;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;36;-868.6987,787.2321;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;31;-1096.082,607.8109;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;32;-1104.964,851.1835;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;33;-1335.901,868.9462;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-643.0918,678.8694;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClipNode;4;-290.6445,46.8352;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;26;-2358.819,810.537;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-2398.605,993.7005;Inherit;False;Property;_Float3;Float 1;7;0;Create;True;0;0;False;0;0.5417061;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;25;-2654.69,815.651;Inherit;True;Property;_TextureSample6;Texture Sample 2;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-1875.758,893.225;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;24;-2881.932,823.9174;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-1630.789,916.912;Inherit;False;Property;_Float5;Float 4;10;0;Create;True;0;0;False;0;1.5;0;0;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-2101.632,841.6703;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-2120.26,1076.5;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;34;-1630.789,819.2076;Inherit;False;Property;_Float4;Float 4;9;0;Create;True;0;0;False;0;0.2883475;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;ASEMaterialInspector;0;0;Standard;Shader_Plante_Grow;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;AlphaTest;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;12;0
WireConnection;22;0;20;0
WireConnection;22;1;21;0
WireConnection;14;0;13;0
WireConnection;18;1;22;0
WireConnection;17;1;18;0
WireConnection;15;0;14;0
WireConnection;15;1;16;0
WireConnection;19;0;15;0
WireConnection;19;1;17;0
WireConnection;9;0;11;0
WireConnection;9;1;19;0
WireConnection;38;0;3;0
WireConnection;38;1;9;0
WireConnection;1;0;2;0
WireConnection;7;0;38;0
WireConnection;10;0;11;0
WireConnection;10;1;30;0
WireConnection;36;0;31;0
WireConnection;36;1;32;0
WireConnection;31;0;10;1
WireConnection;31;1;34;0
WireConnection;32;0;10;1
WireConnection;32;1;33;0
WireConnection;33;0;34;0
WireConnection;33;1;35;0
WireConnection;37;0;31;0
WireConnection;37;1;36;0
WireConnection;4;0;5;0
WireConnection;4;1;7;0
WireConnection;4;2;1;0
WireConnection;26;0;25;0
WireConnection;25;0;12;0
WireConnection;25;1;24;0
WireConnection;30;0;27;0
WireConnection;30;1;29;0
WireConnection;24;0;23;0
WireConnection;24;1;22;0
WireConnection;27;0;26;0
WireConnection;27;1;28;0
WireConnection;0;2;4;0
ASEEND*/
//CHKSM=A6EC7D4996F00DDE2AAA1A1015930A354C8A4F4C