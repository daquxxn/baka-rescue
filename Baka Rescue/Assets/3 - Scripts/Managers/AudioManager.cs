using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Zblah.Utils;

public enum EStepSurface
{
    WOOD,
    ROCK,
    NONE
};

public class AudioManager : Singleton<AudioManager>
{
    // Bruit de pas suivant surface

    #region Fields
    [SerializeField] private AudioSource _musicSource = null;
    [SerializeField] private AudioSource _SFXSource = null;
    [SerializeField] private AudioClipData[] _SFXDatabase = null;
    [SerializeField] private AudioClipData[] _musicDatabase = null;
    [SerializeField] private AudioClipData[] _stepDatabase = null;

    private float _fadeTimeStamp = 0;
    private float _currentFadeTime = 0;
    private float _startPitch = 0;
    private bool _isFadingOut = false;
    private bool _isFadingIn = false;
    private bool _shouldTransit = false;

    private AudioClip _nextMusic = null;
    #endregion Fields

    #region Methods
    #region Mono
    protected override void Start()
    {
        base.Start();
        _startPitch = _SFXSource.pitch;
    }

    protected override void Update()
    {
        base.Update();

        if (_isFadingOut)
        {
            _fadeTimeStamp += Time.deltaTime;
            _musicSource.volume = Mathf.Lerp(1f, 0f, _fadeTimeStamp /_currentFadeTime);
            if (_fadeTimeStamp >= _currentFadeTime)
            {
                _fadeTimeStamp = 0;
                _isFadingOut = false;
                if (_shouldTransit)
                {
                    _isFadingIn = true;
                    _musicSource.clip = _nextMusic;
                    _musicSource.Play();
                }
            }
        }

        if (_isFadingIn)
        {
            _fadeTimeStamp += Time.deltaTime;
            _musicSource.volume = Mathf.Lerp(0, 1, _fadeTimeStamp / _currentFadeTime);
            if (_fadeTimeStamp >= _currentFadeTime)
            {
                _fadeTimeStamp = 0;
                _isFadingIn = false;
            }
        }
    }
    #endregion Mono

    #region SFX
    /// <summary>
    /// Play specified SFX
    /// </summary>
    /// <param name="key"></param>
    public void PlaySFX(string key)
    {
        _SFXSource.pitch = _startPitch;
        AudioClip clip = GetSFXByKey(key);
        _SFXSource.PlayOneShot(clip);
    }

    /// <summary>
    /// Play specified SFX
    /// </summary>
    /// <param name="key"></param>
    public void PlayStepSound(EStepSurface stepSurface)
    {
        AudioClip clip = null;
        clip = GetStepBySurface(stepSurface);
        _SFXSource.PlayOneShot(clip);
    }

    /// <summary>
    /// Play specified random SFX
    /// </summary>
    /// <param name="key"></param>
    public void PlayRandomSFX(string key)
    {
        _SFXSource.pitch = _startPitch;
        AudioClip clip = GetSFXByKey(key, true);
        _SFXSource.PlayOneShot(clip);
    }

    /// <summary>
    /// Play specified SFX with random pitch between min/max
    /// </summary>
    /// <param name="key"></param>
    /// <param name="minPitch"></param>
    /// <param name="maxPitch"></param>
    public void PlaySFXPitched(string key, float minPitch, float maxPitch)
    {
        _SFXSource.pitch = Random.Range(minPitch, maxPitch);
        AudioClip clip = GetSFXByKey(key);
        _SFXSource.PlayOneShot(clip);
    }
    #endregion SFX

    #region Music
    /// <summary>
    /// Play specified SFX
    /// </summary>
    /// <param name="key"></param>
    public void PlayMusic(string key)
    {
        AudioClip clip = GetMusicByKey(key);
        _musicSource.clip = clip;
        _musicSource.Play();
    }

    /// <summary>
    /// Fade out current music
    /// </summary>
    /// <param name="fadeDuration"></param>
    public void MusicFadeOut(float fadeDuration = 1)
    {
        _currentFadeTime = fadeDuration;
        _isFadingOut = true;
    }

    /// <summary>
    /// Fade in current music
    /// </summary>
    /// <param name="fadeDuration"></param>
    public void MusicFadeIn(float fadeDuration = 1)
    {
        _currentFadeTime = fadeDuration;
        _isFadingIn = true;
    }

    /// <summary>
    /// Transition from a music to a specified other  with fade out / fade in
    /// </summary>
    /// <param name="fadeDuration"></param>
    public void MusicTranstition(string key, float fadeDuration = 1)
    {
        _currentFadeTime = fadeDuration;
        _isFadingOut = true;
        _shouldTransit = true;
        _nextMusic = GetMusicByKey(key);
    }
    #endregion Music

    #region Data
    /// <summary>
    /// Extract specified SFX from database
    /// </summary>
    /// <param name="key"></param>
    /// <param name="_isRandom"></param>
    /// <returns></returns>
    private AudioClip GetSFXByKey(string key, bool _isRandom = false)
    {
        for (int i = 0; i < _SFXDatabase.Length; i++)
        {
            if (_SFXDatabase[i].Key.Equals(key))
            {
                if (_isRandom)
                    return _SFXDatabase[i].RandomClip;
                else
                    return _SFXDatabase[i].Clip;
            }
        }
        Debug.LogError("No " + key + " sfx found.");
        return null;
    }

    /// <summary>
    /// Extract specified SFX from database
    /// </summary>
    /// <param name="key"></param>
    /// <param name="_isRandom"></param>
    /// <returns></returns>
    private AudioClip GetStepBySurface(EStepSurface surface)
    {
        for (int i = 0; i < _SFXDatabase.Length; i++)
        {
            if (_stepDatabase[i].Key.Equals(surface.ToString()))
            {
                return _SFXDatabase[i].RandomClip;
            }
        }
        Debug.LogError("No " + surface.ToString() + " step sound found.");
        return null;
    }

    /// <summary>
    /// Extract specified music from database
    /// </summary>
    /// <param name="key"></param>
    /// <param name="_isRandom"></param>
    /// <returns></returns>
    private AudioClip GetMusicByKey(string key, bool _isRandom = false)
    {
        for (int i = 0; i < _musicDatabase.Length; i++)
        {
            if (_musicDatabase[i].Key.Equals(key))
            {
                if (_isRandom)
                    return _musicDatabase[i].RandomClip;
                else
                    return _musicDatabase[i].Clip;
            }
        }
        Debug.LogError("No " + key + " music found.");
        return null;
    }
    #endregion Data
    #endregion Methods
}
