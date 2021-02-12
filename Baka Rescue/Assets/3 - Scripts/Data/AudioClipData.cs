using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "AudioClipData", menuName = "Database/ClipData")]
public class AudioClipData : ScriptableObject
{
    [SerializeField] private string _key = "AUDIOCLIP_NAME";
    [SerializeField] private AudioClip[] _clips = null;

    public string Key => _key;
    public AudioClip Clip => _clips[0];
    public AudioClip RandomClip => _clips[Random.Range(0, _clips.Length)];
}
