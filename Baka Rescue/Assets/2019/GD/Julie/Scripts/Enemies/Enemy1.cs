using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy1 : BaseEnemy
{
    [SerializeField] private int _rotationSpeed = 10;
    [SerializeField] private Transform _trans = null;
    [SerializeField] private int _dir = -1; 
    [SerializeField] private float _clampRotation = 0f;

    [SerializeField] private ElementalProjectile _firePrefab = null;

    [SerializeField] private Transform _projectileContainer = null;

    [SerializeField] private float _iTime = 1.5f;
    [SerializeField] private float _iCounter = 0;

    [SerializeField] private Transform _bulletSpawner = null;

    [Header("stun")]
    private float _stunTimeStamp = 0f;
    [SerializeField] private float _stunDuration = 2f;
    [SerializeField] private GameObject _stunFX = null;
    [SerializeField] private bool _isStun = false;

    private AudioSource _audio;


    private void Start()
    {
        _audio = GetComponent<AudioSource>();
    }

    private void Update()
    {
        if(_dir == 1 && _trans.rotation.x >= _clampRotation/1000)
         {
             _dir = -1;
         }
         else if(_trans.rotation.x <= -_clampRotation/1000)
         {
             _dir = 1;
         }
        _trans.transform.Rotate(Vector3.right * (_rotationSpeed * _dir * Time.deltaTime));

        Vector3 dirSpell = - transform.eulerAngles;

        _iCounter += Time.deltaTime;

        if (_iCounter >= _iTime && _isStun == false)
        {
            FireProjectile(dirSpell); ;
            _iCounter = 0;
        }

        if (_isStun)
        {
            _stunTimeStamp += Time.deltaTime;

            if (_stunTimeStamp >= _stunDuration)
            {
                _isStun = false;
                _stunTimeStamp = 0;
                UnStun();
            }
        }

    }

    public void Stun()
    {
        _rotationSpeed = 0;
        _isStun = true;
        _stunFX.SetActive(true);
    }

    public void UnStun()
    {
        _rotationSpeed = 20;
        _isStun = false;
        _stunFX.SetActive(false);
    }

    private void FireProjectile(Vector3 dirSpell)
    {
        ElementalProjectile elementalProjectile = Instantiate(_firePrefab, _bulletSpawner.position, transform.rotation, _projectileContainer);
        
            elementalProjectile.Init(- elementalProjectile.transform.up, gameObject.GetInstanceID());

        _audio.Play();
    }
    
}